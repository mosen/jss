import Foundation

/**
 The Printer class contains information about a mapped printer on a computer.
 */
public class Printer {
    /// Name of the printer queue
    public var name: String? = nil
    /// The URI of the connection to the printer.
    public var uri: URL? = nil
    /// The printer "model", which commonly refers to the PPD name (without extension), or the name in `lpinfo -m`.
    public var type: String? = nil
    /// The printer location (which may also be a description)
    public var location: String? = nil
}
