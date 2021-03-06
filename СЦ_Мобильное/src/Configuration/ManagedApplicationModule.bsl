//добавлен комментарий
Процедура ПриНачалеРаботыСистемы()
	// Вставить содержимое обработчика.
	//Попытка
	//	#Если МобильноеПриложениеКлиент Тогда
	//		НомерПриложения = "679786957300";
	//		IDПодписчика = ДоставляемыеУведомления.ПолучитьИдентификаторПодписчикаУведомлений(НомерПриложения);
	//		ОбщегоНазначения.УстановитьIDПриложения(IDПодписчика);
	//		ДоставляемыеУведомления.ПодключитьОбработчикУведомлений("ПриПолученииУведомления");
	//	#КонецЕсли
	//Исключение
	//	
	//КонецПопытки;
КонецПроцедуры

Процедура АвтоматическийОбменДанными() Экспорт
	ОбработчикФоновыхЗаданий.ВыполнитьОбменВФоне();
КонецПроцедуры	

Процедура ПередНачаломРаботыСистемы(Отказ)
	// Вставить содержимое обработчика.
	Интервал = ОбщегоНазначения.ПолучитьИнтервалАвтоматическогоОбменаДанными();
	Если Интервал <> 0 Тогда
		ПодключитьОбработчикОжидания("АвтоматическийОбменДанными", Интервал);
	КонецеСли;	
	
КонецПроцедуры


Процедура ПриПолученииУведомления(Уведомление, Локальное, Показано) Экспорт
	Если Локальное Тогда
		Сообщить(Уведомление.Текст);
	Иначе
		Сообщить(Уведомление.Текст);
		Если ЗначениеЗаполнено(Уведомление.Данные) Тогда
			СтрокаДанных = СокрЛП(Уведомление.Данные);
			СтрокаДанных = СтрЗаменить(СтрокаДанных, ";", Символы.ПС);
			Кол = СтрЧислоСтрок(СтрокаДанных);
			Если Кол > 1 Тогда
				Мас = Новый Массив;
				Для Сч = 1 По Кол Цикл
					Мас.Добавить(СтрПолучитьСтроку(СтрокаДанных, Сч));
				КонецЦикла;	
			КонецеСли;	
			Если Уведомление.Данные = "Exchange" Тогда
				ОбработчикФоновыхЗаданий.ВыполнитьОбменВФоне();
			ИначеЕсли Уведомление.Данные = "DeleteIM" Тогда	
				МодульСервис.УдалитьМагазины();
			ИначеЕсли Кол > 1 Тогда
				Если Мас[0] = "ChangeServer" Тогда	
					ОбменДаннымиССервисом.СменитьСерверДанных(Мас[1]);
				ИначеЕсли Мас[0] = "ChangeModeOfArrival" Тогда		
					МодульСервис.УстановитьРежимОприходования(Мас[1]);	
				КонецеСли;
			КонецеСли;	
		КонецеСли;	
	КонецеСли;	
Конецпроцедуры	
