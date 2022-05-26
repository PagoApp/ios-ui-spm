public struct ValidationModel: Model {
    public var validation: (String?) -> Bool
    public var error: String
    
    public init(validation: @escaping (String?) -> Bool, error: String) {
        
        self.validation = validation
        self.error = error
    }
}
