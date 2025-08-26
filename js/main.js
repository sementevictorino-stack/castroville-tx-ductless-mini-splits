// Mobile menu functionality
document.addEventListener('DOMContentLoaded', function() {
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const navMenu = document.querySelector('.nav-menu');
    const dropdownToggles = document.querySelectorAll('.dropdown > a');

    // Mobile menu toggle
    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', function() {
            navMenu.classList.toggle('active');
        });
    }

    // Mobile dropdown functionality
    dropdownToggles.forEach(toggle => {
        toggle.addEventListener('click', function(e) {
            if (window.innerWidth <= 768) {
                e.preventDefault();
                const dropdown = this.parentElement;
                dropdown.classList.toggle('active');
            }
        });
    });

    // Close mobile menu when clicking outside
    document.addEventListener('click', function(e) {
        if (!e.target.closest('.nav-container')) {
            navMenu.classList.remove('active');
            document.querySelectorAll('.dropdown').forEach(dropdown => {
                dropdown.classList.remove('active');
            });
        }
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Floating CTA phone number click tracking
    const floatingCTA = document.querySelector('.floating-cta');
    if (floatingCTA) {
        floatingCTA.addEventListener('click', function() {
            // Track phone number clicks
            if (typeof gtag !== 'undefined') {
                gtag('event', 'phone_call', {
                    'event_category': 'engagement',
                    'event_label': 'floating_cta'
                });
            }
        });
    }

    // CTA button click tracking
    document.querySelectorAll('.btn-primary').forEach(btn => {
        btn.addEventListener('click', function() {
            if (typeof gtag !== 'undefined') {
                gtag('event', 'cta_click', {
                    'event_category': 'engagement',
                    'event_label': this.textContent.trim()
                });
            }
        });
    });

    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('.header');
        if (window.scrollY > 100) {
            header.style.background = 'rgba(26, 0, 51, 0.95)';
            header.style.backdropFilter = 'blur(10px)';
        } else {
            header.style.background = '#1a0033';
            header.style.backdropFilter = 'none';
        }
    });

    // Form submission tracking
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function() {
            if (typeof gtag !== 'undefined') {
                gtag('event', 'form_submit', {
                    'event_category': 'engagement',
                    'event_label': 'quote_form'
                });
            }
        });
    });

    // Intersection Observer for animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe elements for animation
    document.querySelectorAll('.service-card, .feature-item, .content-section').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });

    // Emergency service highlight
    const emergencyBanner = document.querySelector('.emergency-banner');
    if (emergencyBanner) {
        setInterval(() => {
            emergencyBanner.style.transform = 'scale(1.02)';
            setTimeout(() => {
                emergencyBanner.style.transform = 'scale(1)';
            }, 200);
        }, 5000);
    }

    // Local business schema markup
    const businessSchema = {
        "@context": "https://schema.org",
        "@type": "HVACBusiness",
        "name": "Brandywine Ductless Mini Splits",
        "description": "Professional ductless mini split installation, repair, and maintenance services in Brandywine, MD and surrounding areas.",
        "telephone": "+1-888-918-9104",
        "url": window.location.origin,
        "address": {
            "@type": "PostalAddress",
            "streetAddress": "123 Main Street",
            "addressLocality": "Brandywine",
            "addressRegion": "MD",
            "postalCode": "20613"
        },
        "geo": {
            "@type": "GeoCoordinates",
            "latitude": "38.7101",
            "longitude": "-76.8586"
        },
        "openingHours": "Mo,Tu,We,Th,Fr,Sa,Su 00:00-23:59",
        "areaServed": [
            "Brandywine, MD",
            "Waldorf, MD",
            "La Plata, MD",
            "Clinton, MD",
            "Fort Washington, MD"
        ],
        "serviceType": [
            "Ductless Mini Split Installation",
            "HVAC Repair",
            "Air Conditioning Service",
            "Heating System Maintenance"
        ],
        "hasOfferCatalog": {
            "@type": "OfferCatalog",
            "name": "HVAC Services",
            "itemListElement": [
                {
                    "@type": "Offer",
                    "itemOffered": {
                        "@type": "Service",
                        "name": "Ductless Mini Split Installation"
                    }
                }
            ]
        },
        "aggregateRating": {
            "@type": "AggregateRating",
            "ratingValue": "4.9",
            "reviewCount": "127"
        }
    };

    // Add schema to page
    const script = document.createElement('script');
    script.type = 'application/ld+json';
    script.textContent = JSON.stringify(businessSchema);
    document.head.appendChild(script);
});

// Contact form handler
function handleContactForm(event) {
    event.preventDefault();
    
    // Track form submission
    if (typeof gtag !== 'undefined') {
        gtag('event', 'contact_form_submit', {
            'event_category': 'lead_generation',
            'event_label': 'main_contact_form'
        });
    }
    
    // Show success message
    alert('Thank you for your inquiry! We will contact you within 24 hours to schedule your free estimate.');
    
    // Reset form
    event.target.reset();
}

// Phone number formatter
function formatPhoneNumber(input) {
    const value = input.value.replace(/\D/g, '');
    const formattedValue = value.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
    input.value = formattedValue;
}

// Service area calculator
function isInServiceArea(zipCode) {
    const serviceZips = [
        '20613', '20601', '20602', '20603', '20604', '20646', '20695', '20744',
        '20745', '20746', '20747', '20748', '20772', '20774', '20735', '20607',
        '20608', '20609', '20736', '20737', '20738', '20743'
    ];
    return serviceZips.includes(zipCode);
}

// Emergency service checker
function checkEmergencyService() {
    const now = new Date();
    const hour = now.getHours();
    
    if (hour < 8 || hour > 18) {
        const emergencyNotice = document.createElement('div');
        emergencyNotice.className = 'emergency-notice';
        emergencyNotice.innerHTML = `
            <p><strong>After Hours Emergency Service Available!</strong></p>
            <p>Call now for 24/7 emergency HVAC service: <a href="tel:+18889189104">+1 (888) 918-9104</a></p>
        `;
        emergencyNotice.style.cssText = `
            background: #ff4444;
            color: white;
            padding: 15px;
            text-align: center;
            position: fixed;
            top: 70px;
            left: 0;
            right: 0;
            z-index: 999;
            box-shadow: 0 2px 10px rgba(0,0,0,0.3);
        `;
        
        document.body.appendChild(emergencyNotice);
        
        // Auto-hide after 10 seconds
        setTimeout(() => {
            emergencyNotice.remove();
        }, 10000);
    }
}

// Initialize emergency service checker
setTimeout(checkEmergencyService, 2000);

// SEO and performance optimizations
document.addEventListener('DOMContentLoaded', function() {
    // Lazy load images
    const images = document.querySelectorAll('img[data-src]');
    const imageObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
                imageObserver.unobserve(img);
            }
        });
    });
    
    images.forEach(img => imageObserver.observe(img));
    
    // Preload critical resources
    const criticalResources = [
        '/css/style.css',
        'https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap'
    ];
    
    criticalResources.forEach(resource => {
        const link = document.createElement('link');
        link.rel = 'preload';
        link.href = resource;
        link.as = resource.includes('.css') ? 'style' : 'font';
        if (resource.includes('font')) {
            link.crossOrigin = 'anonymous';
        }
        document.head.appendChild(link);
    });
});
