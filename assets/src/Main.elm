module Main exposing (..)

import Browser
import Debug exposing (toString)
import Html exposing (..)
import Html.Attributes exposing (class, style, title, type_, value)
import Html.Events exposing (onClick, onInput, onMouseEnter, onMouseLeave)



--Model


type alias Model =
    { todo : String
    , todos : List String
    , todoDescription : String
    , todoDescriptions : List String
    , isShown : Bool
    , todoItemLen : Int
    , emptyStringmsg : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { todo = "", todos = [], todoDescription = "", todoDescriptions = [], isShown = False, todoItemLen = 0, emptyStringmsg = False }
    , Cmd.none
    )


type Msg
    = Noop
    | UpdateTodo String
    | AddTodo
    | RemoveItem String
    | RemoveAll
    | ClearInput
    | ShowAddTodo
    | CancelTodo
    | CheckLen
    | UpdateDescription String
    | AddtodoDescription



----update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )

        UpdateTodo txt ->
            ( { model | todo = txt, emptyStringmsg = String.isEmpty model.todo }, Cmd.none )

        AddTodo ->
            ( { model | todos = model.todo :: model.todos, todoItemLen = List.length model.todos }, Cmd.none )

        RemoveItem text ->
            ( { model | todos = List.filter (\x -> x /= text) model.todos, todoItemLen = model.todoItemLen - 1 }, Cmd.none )

        RemoveAll ->
            ( { model | todos = [] }, Cmd.none )

        ShowAddTodo ->
            ( { model | isShown = True }, Cmd.none )

        CancelTodo ->
            ( { model | isShown = False }, Cmd.none )

        CheckLen ->
            ( { model | todoItemLen = List.length model.todos }, Cmd.none )

        AddtodoDescription ->
            ( { model | todoDescriptions = model.todoDescription :: model.todoDescriptions }, Cmd.none )

        UpdateDescription txt ->
            ( { model | todoDescription = txt }, Cmd.none )

        ClearInput ->
            ( { model | todo = "", todoDescription = "" }, Cmd.none )



-----view


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


todoItem : String -> Html Msg
todoItem todo =
    li []
        [ div [ class "list-container" ]
            [ div [ class "title-section-list" ] [ text todo ]
            , button [ class "mdi mdi-delete-empty delete-section", onClick (RemoveItem todo) ] []
            ]
        ]


todoList : List String -> Html Msg
todoList todos =
    let
        child =
            List.map todoItem todos
    in
    ul [] child


showAdd : Model -> Html Msg
showAdd model =
    if model.isShown then
        div [ class "add-todo" ]
            [ div [ class "title-section" ]
                [ span [] [ text "Title" ]
                , input [ type_ "text", onInput UpdateTodo, value model.todo, onMouseEnter ClearInput ] []
                ]
            , div [ class "descriptio-section" ]
                [ span [] [ text "Description" ]
                , textarea [ value model.todoDescription ] []
                ]
            , div [ class "functionality-section" ]
                [ button [ onClick AddTodo, class "add-todo-button add-btn" ] [ text "ADD" ]
                , button [ onClick CancelTodo, class "add-todo-button cancel-btn" ] [ text "Cancel" ]
                ]
            ]

    else
        div [ class "list-show" ] [ todoList model.todos ]


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ header []
            [ div [ class "header-icon" ] [ span [ class "mdi mdi-calendar-check" ] [] ]
            , div [ class "todo-content" ]
                [ span [ class "todo-header" ] [ text "TODO" ]
                , span [ class "todo-description" ] [ text "Track Activities" ]
                ]
            ]
        , section [ class "section-part" ]
            [ button [ class "add-todo-button", onClick ShowAddTodo ] [ text "ADD TODO" ]
            , div [] [ showAdd model ]
            ]
        , footer [] []
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
