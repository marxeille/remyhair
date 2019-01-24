
export function isName(name, ignoreNumber = true){

    var reg = ignoreNumber ? /^[^0-9!<>,;?=+()@#"°{}_$%~:]+$/ : /^[^!<>,;?=+()@#"°{}_$%~:]+$/;
    return (reg.test(name) || name.length == 0);
}

export function isEmail(email){
    var reg = /^[a-z\p{L}0-9!#$%&'*+\/=?^`{}|~_-]+[.a-z\p{L}0-9!#$%&'*+\/=?^`{}|~_-]*@[a-z\p{L}0-9]+[._a-z\p{L}0-9-]*\.[a-z\p{L}0-9]+$/i ;
    return (reg.test(email) || email.length == 0);

}

export function isPassword(password){

    return (password.length >= 5 || password.length == 0);
}

export function isPostCode(s, pattern, iso_code)
{
    if (typeof iso_code === 'undefined' || iso_code == '')
        iso_code = '[A-Z]{2}';
    if (typeof(pattern) == 'undefined' || pattern.length == 0)
        pattern = '[a-zA-Z 0-9-]+';
    else
    {
        var replacements = {
            ' ': '(?:\ |)',
            '-': '(?:-|)',
            'N': '[0-9]',
            'L': '[a-zA-Z]',
            'C': iso_code
        };

        for (var new_value in replacements)
            pattern = pattern.split(new_value).join(replacements[new_value]);
    }
    var reg = new RegExp('^' + pattern + '$');
    return (reg.test(s) || s.length == 0);
}


export function isAddress(s)
{
    var reg = /^[^!<>?=+@{}_$%]+$/;
    return (reg.test(s) || s.length == 0);
}

export function isCityName(s)
{
    var reg = /^[^!<>;?=+@#"°{}_$%]+$/;
    return (reg.test(s) || s.length == 0);
}

export function isDni(s)
{
    var reg = /^[0-9a-z-.]{1,16}$/i;
    return (reg.test(s) || s.length == 0);
}
export function isPhoneNumber(s)
{
    var reg = /^[+0-9. ()-]+$/;
    return (reg.test(s) || s.length == 0);
}

export function isGenericName(s)
{
    var reg = /^[^<>={}]+$/;
    return (reg.test(s) || s.length == 0);
}

export function isPrice(price){
    return /^\d{0,10}(\.\d{1,2}){0,1}$/.test(price);
}

export function isPercentage(discount){
    return (/^([0-9]([0-9])?|00)(\.\d{1,2}){0,1}$/.test(discount) || /^100(\.0{1,2})?$/.test(discount));
}

export function isQuantity(quantity){
    return /^([1-9])(\d{0,9}){0,1}$/.test(quantity);
}
export function isReturnQuantity(quantity, maxQuantity){
    return /^([0-9])(\d{0,9}){0,1}$/.test(quantity) && parseInt(quantity) <= parseInt(maxQuantity);
}
export function isReference(reference){
    return /^[^<>;={}!#$%&'*+\/=?^`|~_-]*$/.test(reference);
}
export function isEan13(ean13){
    return /^[0-9]{0,13}$/.test(ean13);
}
export function isUpc(upc){
    return /^[0-9]{0,12}$/.test(upc);
}
export function isNumeric(number){
    return  /^\d+$/.test(number);
}

