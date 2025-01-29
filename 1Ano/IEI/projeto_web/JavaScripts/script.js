document.addEventListener('DOMContentLoaded', function  () {
    const headerElement = document.getElementById('header');
    const changeColorButton = document.getElementById('changeColorButton');
  
    changeColorButton.addEventListener('click', function () {
      // Change the background color when the button is clicked
      headerElement.style.backgroundColor = 'gray';
      headerElement.style.color = 'white';
      console.log(headerElement.style)
    });
  });