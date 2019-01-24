export const REQUEST_ADD_PRODUCT = 'cart/REQUEST_ADD_PRODUCT'
export const RECEIVE_ADD_PRODUCT = 'cart/RECEIVE_ADD_PRODUCT'
export const REQUEST_UPDATE_PRODUCT = 'cart/REQUEST_UPDATE_PRODUCT'
export const REQUEST_REMOVE_PRODUCT = 'cart/REQUEST_REMOVE_PRODUCT'
export const REQUEST_IMPORT_PRODUCTS = 'cart/REQUEST_IMPORT_PRODUCTS'

export function requestAddProduct(jwt, data, isEditing = false, onSuccess, onError) {
    return {
        type: REQUEST_ADD_PRODUCT,
        data: {
            jwt:jwt,
            data: data,
            onError: onError,
            onSuccess: onSuccess,
        },
        isEditing: isEditing
    }
}

export function requestUpdateProduct(jwt, data, isEditing = false, onSuccess, onError) {
    return {
        type: REQUEST_UPDATE_PRODUCT,
        data: {
            data: data,
            jwt: jwt,
            onError: onError,
            onSuccess: onSuccess,
        },
        isEditing: isEditing
    }
}

export function requestRemoveProduct(jwt, data, isEditing = false, onSuccess, onError) {
    return {
        type: REQUEST_REMOVE_PRODUCT,
        data: {
            jwt: jwt,
            data: data,
            onError: onError,
            onSuccess: onSuccess,
        },
        isEditing: isEditing
    }
}

export function requestImportProducts(jwt, data, idCart, isEditing = false, onSuccess, onError) {
    return {
        type: REQUEST_IMPORT_PRODUCTS,
        data: {
            jwt:jwt,
            data: {
                id: idCart,
                products: data
            },
            onError: onError,
            onSuccess: onSuccess,
        },
        isEditing: isEditing
    }
}


