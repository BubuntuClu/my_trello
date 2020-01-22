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
        var new_column = ('<div class="column" id="column_' + column_id + '">' +
                          '  <button class="add_task">Добавить карточку</button>' +
                          '  <button class="remove_column" data-id="' + column_id + '">Удалить колонку</button>' +
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
      url: 'http://' + window.location.host + '/api/v1/columns?id=' + this.dataset["id"] ,
      type: "delete",
      dataType: "json",
      cache: false,
      contentType: false,
      processData: false,
      success: function(data){
        id = data.column_id
        $('#column_' + id).remove()
      },
      error: function(data){
        errors = data.responseJSON;
        console.log('не удалось удалить колонку: ' + data)
      }
    });
  });
});
