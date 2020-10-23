function geturlandredirect(){
    let urlarray = window.location.href.split("/")
    console.log(urlarray)
    urlarray = urlarray.splice(urlarray.length-1,1)
    console.log(urlarray)
    return false
}