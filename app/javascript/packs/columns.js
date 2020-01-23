$(document).ready(function(){
  $('body').on('click', '.add_column', null, function(){
    var form_data = new FormData();
    form_data.append("board_title", window.location.pathname.split('/')[2]);

    $.ajax({
      url: 'http://' + window.location.host + '/api/v1/columns' ,
      data: form_data,
      type: "post",
      dataType: "json",
      cache: false,
      contentType: false,
      processData: false,
      success: function(data){
        var column_id = data.column_id;
        var new_column = ('<div class="column" data-id="' + column_id + '" id="column_' + column_id + '">' +
                          '  <button class="show_task_create_modal">Добавить карточку</button>' +
                          '  <button class="remove_column" data-id="' + column_id + '">Удалить колонку</button>' +
                          '  <div class="task_area" id="task_column_' + column_id + '"></div>' +
                          '</div>');
        $('#column_area').append(new_column);
      },
      error: function(data){
        errors = data.responseJSON;
        console.log('не удалось создать колонку: ' + data)
      }
    });
  });

  $('body').on('click', '.remove_column', null, function(){
    $.ajax({
      url: 'http://' + window.location.host + '/api/v1/columns/' + this.dataset["id"] ,
      type: "delete",
      dataType: "json",
      cache: false,
      contentType: false,
      processData: false,
      success: function(data){
        id = data.column_id;
        $('#column_' + id).remove();
      },
      error: function(data){
        errors = data.responseJSON;
        console.log('не удалось удалить колонку: ' + data)
      }
    });
  });
});



