// Bateman Tree Goods - Vanilla JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Contact button functionality
    const contactBtn = document.getElementById('contactBtn');
    
    if (contactBtn) {
        contactBtn.addEventListener('click', function() {
            alert('Thank you for your interest! Please contact us at info@batemantreegoods.com');
        });
    }

    // Log page load
    console.log('Bateman Tree Goods website loaded successfully');
});
