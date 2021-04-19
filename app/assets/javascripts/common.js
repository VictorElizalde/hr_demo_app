document.addEventListener("turbolinks:load", () => {
  // Sets a timeout of 3 seconds for the notification currently being displayed (if any). After that
  // time, the notification DOM object is removed.
  setTimeout(() => {
    $('.notification__wrapper').fadeOut("slow", () => { $(this).remove(); });
  }, 3000);

  $('.collapsible').collapsible();
  let collapsibleExpandable = document.querySelector('.collapsible.expandable')
  let instance = M.Collapsible.init(collapsibleExpandable, { accordion: false });

  // Updates the text fields of the current HTML page, so that they are 'focused' in a way that the
  // labels do not overlap with their contents.
  M.updateTextFields();

  $('.tabs').tabs();

});

const debounce = (func, delay) => {
  let debounceTimer
  return function() {
      const context = this
      const args = arguments
          clearTimeout(debounceTimer)
              debounceTimer
          = setTimeout(() => func.apply(context, args), delay)
  }
}