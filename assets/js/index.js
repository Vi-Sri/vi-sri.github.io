function geturlandredirect(){
    let urlarray = window.location.href.split("/")
    urlarray = urlarray.splice(urlarray.length-1,1)
    console.log(urlarray.join("/"))
    return false
}