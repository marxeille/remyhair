import * as _ from 'lodash'
export function hasRole(action, actions) {
    return !_.isEmpty(_.filter(actions, (item) => {
        return item.action == action
    }))
}
export function isCallbackFunction(callbackFunction) {
    return (
        typeof callbackFunction !== "undefined" &&
        typeof callbackFunction === "function"
    );
}

export function showPrice(price) {
    if(!price) return '$0';
    return '$'+price
}

export function resize(file, maxWidth, maxHeight, fn) {
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function(event) {
        var dataUrl = event.target.result;

        var image = new Image();
        image.src = dataUrl;
        image.onload = function() {
            var resizedDataUrl = resizeImage(image, 1024, 720, 0.7);
            fn(resizedDataUrl);
        };
    };
}

function resizeImage(image, maxWidth, maxHeight, quality) {
    var canvas = document.createElement('canvas');

    var width = image.width;
    var height = image.height;

    if (width > height) {
        if (width > maxWidth) {
            height = Math.round((height * maxWidth) / width);
            width = maxWidth;
        }
    } else {
        if (height > maxHeight) {
            width = Math.round((width * maxHeight) / height);
            height = maxHeight;
        }
    }

    canvas.width = width;
    canvas.height = height;

    var ctx = canvas.getContext('2d');
    ctx.drawImage(image, 0, 0, width, height);
    return canvas.toDataURL('image/jpeg', quality);
}

export function imgCheck(obj) {
    var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
    if (obj.name.indexOf('jpeg') || obj.name.indexOf('jpg') || obj.name.indexOf('png') || obj.name.indexOf('gif') || obj.name.indexOf('bmp')  ){
        return true;
    }
    alert("Only '.jpeg','.jpg', '.png', '.gif', '.bmp' formats are allowed.");
    return false;

}

export function renderAddress(address, countries, states) {
    const city = _.first(_.filter(states, (states) => states.id == address.id_state));
    const country = _.first(_.filter(countries, (country) => country.id == address.id_country));
    let cityName = !_.isEmpty(city) ? `${city.name}` : '(no state)';
    let countryName = !_.isEmpty(country) ? `${country.name}` : '(no country)';
    return  `${address.address}, ${cityName}, ${countryName}`
}

export function replaceAll(text ,search, replacement) {
    return text.split(search).join(replacement);
};

