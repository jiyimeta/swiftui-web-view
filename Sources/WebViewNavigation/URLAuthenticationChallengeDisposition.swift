import Foundation

/// A wrapper object of `URLSession.AuthChallengeDisposition` that has credential data if needed.
public enum URLAuthenticationChallengeDisposition {
    /// The case to use the specified credential, which may be nil
    case useCredential(URLCredential?)

    /// The case of default handling for the challenge - as if this delegate were not implemented
    case performDefaultHandling

    /// The case where the entire request will be canceled
    case cancelAuthenticationChallenge

    /// The case where this challenge is rejected and the next authentication protection space should be tried
    case rejectProtectionSpace
}

// MARK: - Internal methods

extension URLAuthenticationChallengeDisposition {
    var tuple: (URLSession.AuthChallengeDisposition, URLCredential?) {
        switch self {
        case let .useCredential(credential): (.useCredential, credential)
        case .performDefaultHandling: (.performDefaultHandling, nil)
        case .cancelAuthenticationChallenge: (.cancelAuthenticationChallenge, nil)
        case .rejectProtectionSpace: (.rejectProtectionSpace, nil)
        }
    }
}
