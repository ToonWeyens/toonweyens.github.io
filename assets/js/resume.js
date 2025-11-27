// 1. Helper: Check the state of the section and update the button text
function updateButtonState(section) {
    const btn = section.querySelector('.global-toggle-btn');
    const entries = section.querySelectorAll('.job-entry');
    
    // Check if ANY entry is currently closed
    let hasClosedEntries = false;
    entries.forEach(entry => {
        if (!entry.classList.contains('active')) {
            hasClosedEntries = true;
        }
    });

    // Logic:
    // If even ONE item is closed -> Button should say "Expand All"
    // If ALL items are open -> Button should say "Collapse All"
    if (hasClosedEntries) {
        btn.innerText = "Expand All";
    } else {
        btn.innerText = "Collapse All";
    }
}

// 2. Toggle individual job entry
function toggleJob(headerElement) {
    const entry = headerElement.closest('.job-entry');
    entry.classList.toggle('active');

    // NEW: Find the parent section and update the main button immediately
    // This looks for the closest parent div with an ID (e.g., experience-section)
    const section = entry.closest('div[id]');
    if (section) {
        updateButtonState(section);
    }
}

// 3. Main Button Logic
function toggleSection(sectionId, btnElement) {
    const section = document.getElementById(sectionId);
    const entries = section.querySelectorAll('.job-entry');
    
    // Deciding factor: What does the button currently say?
    const isExpandAction = btnElement.innerText === "Expand All";
    
    entries.forEach(entry => {
        if (isExpandAction) {
            entry.classList.add('active'); // Open everything
        } else {
            entry.classList.remove('active'); // Close everything
        }
    });

    // Update the button text to match the new state
    updateButtonState(section);
}