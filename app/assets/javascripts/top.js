$(document).ready(function() {
    $('#calendar').fullCalendar({

      header: {
              left: 'prev,next today',
              center: 'title',
              right: 'month,agendaWeek'
          },
      eventLimit: true, // allow "more" link when too many events
      eventLimitText:'その他',
      lang:'ja',

      //月曜日開始
      firstDay:1,
      weekends:true,
      //終日スロットル表示
      allDaySlot:true,
      //agendaWeek、agendaDayの1時間4セル（15分間隔）で表示
      slotDuration:'00:30:00',
      //開始（終了）時間がない場合の設定
      defaultTimedEventDuration:'01:00:00',
      //スクロール開始時間
      scrollTime:'06:00:00',

      events: '/events.json',
    });
});
