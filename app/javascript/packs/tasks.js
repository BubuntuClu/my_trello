$(document).ready(function(){
  var create_modal = document.getElementById("create_task_modal");

  var edit_modal = document.getElementById("edit_task_modal");

  var create_span = document.getElementsByClassName("close")[0];
  var edit_span = document.getElementsByClassName("close")[1];

  create_span.onclick = function() {
    create_modal.style.display = "none";
  }

  edit_span.onclick = function() {
    edit_modal.style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target == create_modal || event.target == edit_modal) {
      create_modal.style.display = "none";
      edit_modal.style.display = "none";
    }
  }

  // CREATE
  $('body').on('click', '.show_task_create_modal', null, function(){
    create_modal.style.display = "block";
    column_id = this.parentElement.dataset.id;
    column_creator = $('#column_creator')[0];
    column_creator.dataset.id = column_id
  });

  $('body').on('click', '.create_task', null, function(){
    var form_data = new FormData();
    form_data.append("title", $('#create_task_title')[0].value);

    column_id = $('#column_creator')[0].dataset.id;

    $.ajax({
      url: window.location.origin + '/api/v1/columns/' + column_id + '/tasks',
      data: form_data,
      type: "post",
      dataType: "json",
      cache: false,
      contentType: false,
      processData: false,
      success: function(data){
        $('#create_task_title')[0].value = '';

        var column_id = data.column_id;
        var task_id = data.task_id;
        var task_title = data.task_title;
        var new_task = ('<div class="task" data-id="' + task_id + '" id="task_' + task_id + '">' +
                          '  <button class="remove_task">X</button>' +
                          '  <button class="show_task_edit_modal">Редактировать</button>' +
                          '  <br>' +
                          ' <p>' + task_title + '</p>' +
                          '</div>');
        $('#task_column_' + column_id).append(new_task);
        create_modal.style.display = "none";
      },
      error: function(data){
        errors = data.responseJSON;
        console.log('не удалось создать карточку: ' + data)
      }
    });
  });

  // DESTROY
  $('body').on('click', '.remove_task', null, function(){
    var task_id = this.parentElement.dataset.id;
    $.ajax({
      url: window.location.origin + '/api/v1/tasks/' + task_id,
      type: "delete",
      dataType: "json",
      cache: false,
      contentType: false,
      processData: false,
      success: function(data){
        var task_elem = $('#task_' + data.task_id)[0];
        task_elem.remove();
      },
      error: function(data){
        errors = data.responseJSON;
        console.log('не удалось удалить карточку: ' + data)
      }
    });
  });

  // EDIT
  $('body').on('click', '.show_task_edit_modal', null, function(){
    edit_task_modal.style.display = "block";
    task_id = this.parentElement.dataset.id;
    task_editor = $('#task_editor')[0];
    task_editor.dataset.id = task_id;
    $('#edit_task_title')[0].value = $(this.parentElement).children()[3].textContent;
  });

  $('body').on('click', '.edit_task', null, function(){
    var form_data = new FormData();
    form_data.append("title", $('#edit_task_title')[0].value);

    $.ajax({
      url: window.location.origin + '/api/v1/tasks/' + $('#task_editor')[0].dataset.id,
      data: form_data,
      type: "patch",
      dataType: "json",
      cache: false,
      contentType: false,
      processData: false,
      success: function(data){
        $('#edit_task_title')[0].value = '';
        var task_elem = $('#task_' + data.task_id);
        task_elem.children()[3].textContent = data.task_title;
        edit_modal.style.display = "none";
      },
      error: function(data){
        errors = data.responseJSON;
        console.log('не удалось создать карточку: ' + data)
      }
    });
  });
});
