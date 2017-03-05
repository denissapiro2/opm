#Использовать logos

Перем ПодключенноеЗеркало;
Перем Зеркала;
Перем Лог;

// ИмяРесурса - имя файла относительно "Сервер/ПутьВХранилище"
// Возвращает HttpОтвет или Неопределено, если ни один сервер не вернул ответ.
Функция ПолучитьРесурс(Знач ИмяРесурса) Экспорт

	РесурсУспешноПолучен = Ложь;

	Если ПодключенноеЗеркало = Неопределено Тогда
	
		Для Каждого мЗеркало Из Зеркала Цикл

			Ответ  = мЗеркало.ПолучитьРесурс(ИмяРесурса);
			Если Ответ = Неопределено Тогда
				Продолжить;
			КонецЕсли;

			Если Ответ.КодСостояния = 200 Тогда
				
				РесурсУспешноПолучен = Истина;
				ПодключенноеЗеркало = мЗеркало;
				Прервать;
				
			КонецЕсли;

			ТекстОшибки = СтрШаблон("Ошибка подключения к хабу %1 <%2>",
				мЗеркало.СерверУдаленногоХранилища,
				Ответ.КодСостояния);

			Ответ.Закрыть();

			Лог.Информация(ТекстОшибки);

		КонецЦикла;

	Иначе

		Ответ = ПодключенноеЗеркало.ПолучитьРесурс(ИмяРесурса);
		Если Ответ.КодСостояния = 200 Тогда
			РесурсУспешноПолучен = Истина;
		Иначе

			ТекстОшибки = СтрШаблон("Ошибка подключения к хабу %1 <%2>",
				ПодключенноеЗеркало.СерверУдаленногоХранилища,
				Ответ.КодСостояния);

			Ответ.Закрыть();
			Лог.Информация(ТекстОшибки);

		КонецЕсли;

	КонецЕсли;

	Если РесурсУспешноПолучен Тогда
		
		ТекстСообщения = СтрШаблон("Ресурс %1 успешно получен с %2", ИмяРесурса, ПодключенноеЗеркало.СерверУдаленногоХранилища);
		Лог.Информация(ТекстСообщения);

		Возврат Ответ;

	КонецЕсли;

	Возврат Неопределено;

КонецФункции

Процедура Добавить(Знач Зеркало) Экспорт
	Зеркала.Добавить(Зеркало);
КонецПроцедуры

Процедура Инициализация()

	Лог = Логирование.ПолучитьЛог("oscript.app.opm");

	Зеркала = Новый Массив;

КонецПроцедуры

Инициализация();
