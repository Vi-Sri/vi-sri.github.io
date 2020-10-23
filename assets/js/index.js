function geturlandredirect(){
    let currentUrl = window.location.href
    window.location = currentUrl.split("/").splice(0,-1).join("/")
    return false
}