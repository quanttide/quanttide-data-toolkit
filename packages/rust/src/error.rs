use std::fmt;

#[derive(Debug)]
pub enum BlueprintError {
    CueParse(String),
    Validation(Vec<ValidationError>),
    Io(std::io::Error),
    Serde(String),
}

#[derive(Debug)]
pub struct ValidationError {
    pub field: String,
    pub message: String,
}

impl fmt::Display for ValidationError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}: {}", self.field, self.message)
    }
}

impl fmt::Display for BlueprintError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            BlueprintError::CueParse(msg) => write!(f, "CUE parse error: {msg}"),
            BlueprintError::Validation(errors) => {
                let msgs: Vec<String> = errors.iter().map(|e| e.to_string()).collect();
                write!(f, "Validation errors: {}", msgs.join("; "))
            }
            BlueprintError::Io(e) => write!(f, "IO error: {e}"),
            BlueprintError::Serde(msg) => write!(f, "Serde error: {msg}"),
        }
    }
}

impl std::error::Error for BlueprintError {}

impl From<std::io::Error> for BlueprintError {
    fn from(e: std::io::Error) -> Self {
        BlueprintError::Io(e)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_validation_error_display() {
        let e = ValidationError { field: "name".into(), message: "must not be empty".into() };
        assert_eq!(e.to_string(), "name: must not be empty");
    }

    #[test]
    fn test_cue_parse_error_display() {
        let e = BlueprintError::CueParse("unexpected token".into());
        assert!(e.to_string().contains("CUE parse error"));
        assert!(e.to_string().contains("unexpected token"));
    }

    #[test]
    fn test_validation_errors_display_multiple() {
        let errors = vec![
            ValidationError { field: "a".into(), message: "err1".into() },
            ValidationError { field: "b".into(), message: "err2".into() },
        ];
        let e = BlueprintError::Validation(errors);
        let s = e.to_string();
        assert!(s.contains("a: err1"));
        assert!(s.contains("b: err2"));
    }

    #[test]
    fn test_io_error_display() {
        let io = std::io::Error::new(std::io::ErrorKind::NotFound, "file not found");
        let e = BlueprintError::Io(io);
        assert!(e.to_string().contains("IO error"));
    }

    #[test]
    fn test_serde_error_display() {
        let e = BlueprintError::Serde("bad json".into());
        assert!(e.to_string().contains("Serde error"));
        assert!(e.to_string().contains("bad json"));
    }

    #[test]
    fn test_from_io_error() {
        let io = std::io::Error::new(std::io::ErrorKind::NotFound, "nope");
        let bp: BlueprintError = io.into();
        assert!(matches!(bp, BlueprintError::Io(_)));
    }

    #[test]
    fn test_blueprint_error_is_std_error() {
        let e = BlueprintError::CueParse("test".into());
        let _: &dyn std::error::Error = &e;
    }
}

