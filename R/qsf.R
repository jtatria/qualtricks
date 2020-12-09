SVY_ATTRS <- list(
    SurveyID                = NULL,
    LastModified            = NULL,
    SurveyLanguage          = NULL,
    DivisionID              = NULL,
    SurveyExpirationDate    = NULL,
    LastAccessed            = NULL,
    Deleted                 = NULL,
    SurveyDescription       = NULL,
    SurveyStartDate         = NULL,
    SurveyBrandID           = NULL,
    CreatorID               = NULL,
    SurveyCreationDate      = NULL,
    SurveyName              = NULL,
    SurveyActiveResponseSet = NULL,
    LastActivated           = NULL,
    SurveyStatus            = NULL,
    SurveyOwnerID           = NULL
)

ELT_ATTRS <- list(
    PrimaryAttribute   = NULL,
    TertiaryAttribute  = NULL,
    SecondaryAttribute = NULL,
    SurveyID           = NULL,
    Element            = NULL,
    Payload            = list()
)

ELT_TYPES <- data.frame(
    tag = c(
        "BL",
        "FL",
        "SO",
        "SCO",
        "PROJ",
        "STAT",
        "QC",
        "RS",
        "SQ"
    ),
    name = c(
        "Survey Blocks",
        "Survey Flow",
        "Survey Options",
        "Scoring",
        "CORE",
        "Survey Statistics",
        "Question Count",
        "Default Response Set",
        "Survey Question"
    )
)

BL_PAYLOAD <- list()
FL_PAYLOAD <- list()
SO_PAYLOAD <- list()
SCO_PAYLOAD <- list()
PROJ_PAYLOAD <- list()
STAT_PAYLOAD <- list()
QC_PAYLOAD <- list()
RS_PAYLOAD <- list()

QS_PAYLOAD <- list(
    QuestionID          = NULL,
    QuestionText        = NULL,
    QuestionDescription = NULL,
    QuestionType        = NULL,
    Language            = NULL,
    DataExportTag       = NULL,
    DefaultChoices      = NULL,
    NextAnswerId        = NULL,
    GradingData         = NULL,
    NextChoiceId        = NULL,
    Validation          = list(),
    Choices             = list(),
    ChoiceOrder         = integer(),
    DisplayLogic        = list(),
    Configuration       = list()
)

