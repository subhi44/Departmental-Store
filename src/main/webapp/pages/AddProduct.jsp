<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Add Product | Admin Panel</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

<style>
  html, body {
    height: 100%;
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    transition: background-color 0.3s, color 0.3s;
  }

  body.dark-mode {
    background-color: #121212;
    color: #eee;
  }

  .container-center {
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
  }

  main {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.1);
    max-width: 700px;
    width: 100%;
    padding: 30px;
    transition: background 0.3s, color 0.3s;
  }

  body.dark-mode main {
    background: #1e1e1e;
    color: #ddd;
  }

  h1 {
    margin-bottom: 0.5rem;
  }

  .top-navbar {
    background:linear-gradient(to right, #28a745, #007bff);
    padding: 15px 30px;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
}


  body.dark-mode .top-navbar {
    background-color: #2a3b2a;
  }

  .top-navbar .features i {
    font-size: 18px;
    cursor: pointer;
  }

  label {
    font-weight: 600;
  }

  img#imagePreview {
    display: block;
    max-width: 200px;
    margin-top: 15px;
    border-radius: 12px;
    box-shadow: 0 0 8px rgba(0,0,0,0.1);
  }

  .char-count {
    font-size: 0.9rem;
    color: #555;
    float: right;
    margin-top: -25px;
    margin-bottom: 15px;
  }

  body.dark-mode .char-count {
    color: #bbb;
  }

  /* Toast container */
  .toast-container {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 1080;
  }
</style>

<script>
  function previewImage() {
    const input = document.getElementById('image');
    const preview = document.getElementById('imagePreview');
    const file = input.files[0];

    if (file) {
      const reader = new FileReader();
      reader.onload = function(e) {
        preview.src = e.target.result;
        preview.style.display = 'block';
      };
      reader.readAsDataURL(file);
    } else {
      preview.src = '';
      preview.style.display = 'none';
    }
  }

  function generateSlug() {
    const nameInput = document.getElementById('name');
    const slugInput = document.getElementById('slug');
    let slug = nameInput.value.toLowerCase()
                .replace(/[^\w\s-]/g, '')  // Remove special chars except whitespace and dash
                .replace(/\s+/g, '-')      // Replace spaces with dash
                .replace(/-+/g, '-');      // Replace multiple dashes with one
    slugInput.value = slug;
  }

  function formatPrice() {
    const priceInput = document.getElementById('price');
    let val = priceInput.value.replace(/,/g, '');
    if (!isNaN(val) && val.length > 0) {
      val = parseInt(val, 10);
      priceInput.value = val.toLocaleString();
    }
  }

  function showToast(message, isSuccess = true) {
    const toastEl = document.createElement('div');
    toastEl.className = `toast ${isSuccess ? 'bg-success' : 'bg-danger'} text-white`;
    toastEl.style.minWidth = '250px';
    toastEl.setAttribute('role', 'alert');
    toastEl.setAttribute('aria-live', 'assertive');
    toastEl.setAttribute('aria-atomic', 'true');
    toastEl.innerHTML = `
      <div class="toast-header ${isSuccess ? 'bg-success' : 'bg-danger'} text-white">
          <strong class="mr-auto">${isSuccess ? 'Success' : 'Error'}</strong>
          <button type="button" class="ml-2 mb-1 close text-white" data-dismiss="toast" aria-label="Close">
              <span aria-hidden="true">&times;</span>
          </button>
      </div>
      <div class="toast-body">${message}</div>
    `;
    document.getElementById('toastContainer').appendChild(toastEl);
    $(toastEl).toast({ delay: 4000 });
    $(toastEl).toast('show');
    $(toastEl).on('hidden.bs.toast', function () {
      toastEl.remove();
    });
  }

  function updateCharCount() {
    const desc = document.getElementById('description');
    const count = desc.value.length;
    const max = desc.getAttribute('maxlength') || 500;
    const counter = document.getElementById('descCharCount');
    counter.textContent = `${count} / ${max} characters`;
  }

  function toggleDarkMode() {
    document.body.classList.toggle('dark-mode');
  }

  function clearForm() {
    if (confirm('Are you sure you want to clear the form? All data will be lost.')) {
      document.getElementById('productForm').reset();
      document.getElementById('imagePreview').style.display = 'none';
      document.getElementById('slug').value = '';
      updateCharCount();
    }
  }

  // Live validation feedback
  function validateField(field) {
    if (field.checkValidity()) {
      field.classList.remove('is-invalid');
      field.classList.add('is-valid');
    } else {
      field.classList.remove('is-valid');
      field.classList.add('is-invalid');
    }
  }

  document.addEventListener('DOMContentLoaded', () => {
    const nameInput = document.getElementById('name');
    const priceInput = document.getElementById('price');
    const descInput = document.getElementById('description');
    const categorySelect = document.getElementById('category');
    const form = document.getElementById('productForm');

    nameInput.addEventListener('input', () => {
      generateSlug();
      validateField(nameInput);
    });
    priceInput.addEventListener('input', () => {
      validateField(priceInput);
    });
    priceInput.addEventListener('blur', formatPrice);
    descInput.addEventListener('input', () => {
      updateCharCount();
      validateField(descInput);
    });
    categorySelect.addEventListener('change', () => {
      validateField(categorySelect);
    });

    updateCharCount();

    // Submit on Ctrl+S or Cmd+S
    window.addEventListener('keydown', (e) => {
      if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 's') {
        e.preventDefault();
        if (form.checkValidity()) {
          form.submit();
        } else {
          showToast('Please fill out all required fields correctly before saving.', false);
        }
      }
    });

    form.addEventListener('submit', (e) => {
      if (!form.checkValidity()) {
        e.preventDefault();
        e.stopPropagation();
        form.classList.add('was-validated');
        showToast('Please fill out all required fields correctly.', false);
      }
    });

    // Clear form button
    document.getElementById('clearBtn').addEventListener('click', (e) => {
      e.preventDefault();
      clearForm();
    });

  });
 
</script>

</head>
<body>

<div class="top-navbar">
  <h4>Add Product | Admin Panel</h4>
  <div class="features">
    <i class="bi bi-moon-fill" title="Toggle Dark Mode" onclick="toggleDarkMode()"></i>
  </div>
</div>

<div class="container-center">
  <main>
    <h1>Add New Product</h1>
    <p>Fill in the details below to add a product</p>
    <form id="productForm" method="post" action="AddProductServlet" enctype="multipart/form-data" novalidate>
      <div class="form-group">
        <label for="name">Product Name <span class="text-danger">*</span></label>
        <input type="text" class="form-control" id="name" name="name" required placeholder="Enter product name" />
        <div class="invalid-feedback">Please enter the product name.</div>
      </div>

      <div class="form-group">
        <label for="slug">Slug</label>
        <input type="text" class="form-control" id="slug" name="slug" placeholder="Auto-generated slug" readonly />
      </div>

      <div class="form-group">
        <label for="price">Price (₹) <span class="text-danger">*</span></label>
        <input type="text" class="form-control" id="price" name="price" required pattern="^\d{1,10}(,\d{3})*$"
          placeholder="Enter price (e.g., 1,500)" />
        <small class="form-text text-muted">Enter price without decimals. Use numbers only.</small>
        <div class="invalid-feedback">Please enter a valid price.</div>
      </div>

      <div class="form-group">
        <label for="category">Category <span class="text-danger">*</span></label>
        <select id="category" name="category" class="form-control" required>
          <option value="">-- Select Category --</option>
          <option value="beverages">Beverages</option>
          <option value="groceries">Groceries</option>
          <option value="household">Household</option>
          <option value="personal care">Personal Care</option>
          <option value="electronics">Electronics</option>
          <option value="fashion">Fashion</option>
        </select>
        <div class="invalid-feedback">Please select a category.</div>
      </div>

      <div class="form-group">
        <label for="description">Description <span class="text-danger">*</span></label>
        <textarea id="description" name="description" rows="3" class="form-control" required placeholder="Enter product description" maxlength="500"></textarea>
        <div class="char-count" id="descCharCount">0 / 500 characters</div>
        <div class="invalid-feedback">Please enter a description.</div>
      </div>

      <div class="form-group">
        <label for="image">Product Image <span class="text-danger">*</span></label>
        <input type="file" class="form-control-file" id="image" name="image" accept="image/*" required onchange="previewImage()" />
        <img id="imagePreview" alt="Image Preview" style="display:none;" />
        <div class="invalid-feedback">Please upload an image.</div>
      </div>

      <button type="submit" class="btn btn-primary btn-block mb-2">
        <i class="bi bi-plus-circle"></i> Add Product
      </button>
      <button id="clearBtn" class="btn btn-secondary btn-block" type="button">
        <i class="bi bi-x-circle"></i> Clear Form
      </button>
    </form>
  </main>
</div>

<!-- Toast container -->
<div id="toastContainer" class="toast-container"></div>

<!-- Bootstrap JS & dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html><!-- ends here -->
