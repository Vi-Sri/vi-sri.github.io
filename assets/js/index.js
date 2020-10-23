function geturlandredirect(){
    alert("Clicked motherfucker.. !!!")
    let currentUrl = window.location.href
    window.location = currentUrl.split("/").splice(0,-1).join("/")
}