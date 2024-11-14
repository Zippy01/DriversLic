window.addEventListener("message", function(event) {
    if (event.data.action === "show") {
        document.getElementById("license-container").style.display = "block"; // Show the UI

        
        document.getElementById("fn").innerText = "FN: " + event.data.fn;
        document.getElementById("ln").innerText = "LN: " + event.data.ln;
        document.getElementById("address").innerText = "Adr: " + event.data.address;
        document.getElementById("dob").innerText = "DOB: " + event.data.dob;
        document.getElementById("license_number").innerText = "DLN : " + event.data.license_number;
        document.getElementById("id").innerText = "ID : " + event.data.id;

    } else if (event.data.action === "hide") {
        document.getElementById("license-container").style.display = "none"; 
    }
});