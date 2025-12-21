// Ordinary Tree Goods - Vanilla JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Set current year in footer
    const yearEl = document.getElementById('year');
    if (yearEl) {
        yearEl.textContent = new Date().getFullYear();
    }

    // Log page load
    console.log('Ordinary Tree Goods website loaded successfully');
});
