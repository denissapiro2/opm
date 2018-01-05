Функция ПрочитатьОписаниеПакета() Экспорт

	Описание = Новый ОписаниеПакета();

	ПутьКМанифесту = ОбъединитьПути(ТекущийКаталог(), КонстантыOpm.ИмяФайлаСпецификацииПакета);
	
	Файл_Манифест = Новый Файл(ПутьКМанифесту);
	Если Файл_Манифест.Существует() Тогда
		Контекст = Новый Структура("Описание", Описание);
		ЗагрузитьСценарий(ПутьКМанифесту, Контекст);
	КонецЕсли;

	Возврат Описание;

КонецФункции
