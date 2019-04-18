$(document).on("turbolinks:load", function() {
  var selectizeCallback = null;

  $(".tag-modal").on("hide.bs.modal", function(e) {
    if (selectizeCallback != null) {
      selectizeCallback();
      selecitzeCallback = null;
    }

    $("#new_tag").trigger("reset");
    $.rails.enableFormElements($("#new_tag"));
  });

  $("#new_tag").on("submit", function(e) {
    e.preventDefault();
    $.ajax({
      method: "POST",
      url: $(this).attr("action"),
      data: $(this).serialize(),
      success: function(response) {
        selectizeCallback({value: response.id, text: response.name});
        selectizeCallback = null;

        $(".tag-modal").modal('toggle');
      }
    });
  });

  $(".selectize").selectize({
    create: function(input, callback) {
      selectizeCallback = callback;

      $(".tag-modal").modal();
      $("#tag_name").val(input);
    }
  });
});