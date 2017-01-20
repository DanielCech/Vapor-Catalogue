enum JWTError: Error {
    case couldNotLogIn
    case couldNotVerifyClaims
    case couldNotVerifySignature
}
