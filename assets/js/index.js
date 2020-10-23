function geturlandredirect(){
    let urlarray = window.location.href.split("/")
    urlarray.splice(urlarray.length-1,1)
    window.location.href = urlarray.join("/")
    return false
}