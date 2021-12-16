import jester

type
  TData* = ref object of RootObj
    loggedIn*: bool
    userid*, username*, userpass*, email*: string
    req*: Request
