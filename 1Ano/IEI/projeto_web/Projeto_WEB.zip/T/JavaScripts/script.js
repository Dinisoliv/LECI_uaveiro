var users = [];

function createAccount() {
    var newUsername = document.getElementById('newUsername').value;
    var newPassword = document.getElementById('newPassword').value;

    if (users.some(user => user.username === newUsername)) {
        alert('Username already exists. Please choose a different username.');
    } else {
        users.push({ username: newUsername, password: newPassword });
        alert('Account created successfully!');
    }
}
function validateLogin() {
  var username = document.getElementById('username').value;
  var password = document.getElementById('password').value;

  var user = users.find(user => user.username === username && user.password === password);
  if (user) {
      alert('Login successful!');
      showUserIcon(user.username);
  } else {
      alert('Invalid credentials. Please try again.');
  }
}

function toggleForm() {
  var loginForm = document.getElementById('loginForm');
  var registrationForm = document.getElementById('registrationForm');
  var formHeader = document.getElementById('formHeader');

  if (loginForm.style.display === 'none') {
      loginForm.style.display = 'block';
      registrationForm.style.display = 'none';
      formHeader.textContent = 'Login';
  } else {
      loginForm.style.display = 'none';
      registrationForm.style.display = 'block';
      formHeader.textContent = 'Create Account';
  }
}

function showUserIcon(username) {
  var userIcon = document.getElementById('userIcon');
  var userImage = document.getElementById('userImage');

  userImage.alt = username; // Set alt attribute to username
  userImage.src = 'user-icon.png'; // Change the image source as needed
  userIcon.style.display = 'block';
}