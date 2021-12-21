import smtp
import strformat

proc sendVerify*(email, username: string, key: string) =
    var msg = createMessage("verify your changeblog account",
                            &"http://changeblog.prestosilver.info/confirm?user={username}&key={key}",
                            @[email])
    let smtpConn = newSmtp(useSsl = false, debug = true)
    smtpConn.connect("smtppro.zoho.com", Port 587)
    smtpConn.startTls()
    smtpConn.auth("prestosilver@prestosilver.info", "!Hellow16795")
    smtpConn.sendmail("prestosilver@prestosilver.info", @[
            email], $msg)

when isMainModule:
    sendVerify("prestosilver.ptp@gmail.com", "lol", "lmao")
