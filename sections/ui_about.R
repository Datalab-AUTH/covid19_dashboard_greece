body_about <- dashboardBody(
  fluidRow(
    fluidRow(
      column(
        box(
          title = div("Πληροφοριακή πλατφόρμα για τον κορωνοϊό", style = "padding-left: 20px", class = "h2"),
          column(
            "Η πλατφόρμα CovidDExp (COVID-19 Data Exploration) αποτελεί ένα
            εργαλείο διερεύνησης, ανάλυσης
            κι οπτικοποίησης δεδομένων που σχετίζονται με την πανδημία του
            κορωνοϊού COVID-19.
            Περιλαμβάνει την επεξεργασία αξιόπιστων και σε πραγματικό χρόνο
            εξελισσόμενων δεδομένων σε σχέση
            με μια σειρά επιλεγμένων δεικτών για την παρακολούθηση και την
            περιγραφή της παγκόσμιας επιδημίας σε εθνικό επίπεδο.",
            br(),
            h3("Κίνητρο"),
            "Το CovidDExp είναι αποτέλεσμα της επιστημονικής περιέργειας και της
            προθυμίας για την διερεύνηση και
            κατανόηση της παγκόσμιας πανδημικής κρίσης, από την πλευρά των
            επιστημόνων των δεδομένων (Data Scientists).
            Πέρα από τις πανδημικές και επιδημικές στατιστικές αναλύσεις, πρόθεσή
            μας είναι να ανακαλύψουμε και να ερευνήσουμε πιθανές συσχετίσεις και
            συνδέσεις με άλλους δείκτες (κοινωνικοοικονομικούς, κυβερνητικούς,
            κτλ.) που μπορεί να επισημάνουν εναλλακτικές οπτικές γωνίες και να
            παρέχουν περισσότερες πληροφορίες στους εκάστοτε ενδιαφερόμενους.
            Η πρωτοβουλία αυτή ξεκίνησε και υποστηρίζεται από τα μέλη του
            εργαστηρίου επιστήμης δεδομένων και παγκόσμιου ιστού",
            tags$a(href = "https://datalab.csd.auth.gr",
                   "Data and Web Science Lab"),
            "(DATALAB),",
            "μια ενεργή ερευνητική ομάδα που ασχολείται με την έρευνα και την καινοτομία στην
            επιστήμη κι ανάλυση δεδομένων πολλαπλών πεδίων και στις Τεχνολογίες 
            ληροφορικής κι Επικοινωνιών στο ",
            tags$a(href = "https://www.csd.auth.gr","Tμήμα Πληροφορικής")," του",
            tags$a(href = "https://www.csd.auth.gr",
                   "Αριστοτέλειου Πανεπιστημίου Θεσσαλονίκης"),
            "Καθώς, για προφανείς λόγους, η περίπτωση της Ελλάδας είναι
            εξέχουσας σημασίας, η υπάρχουσα πλατφόρμα επικεντρώνεται στην
            εξέταση της εξέλιξης των δεδομένων στον Ελλαδικό χώρο. Ωστόσο, στον
            παρακάτω σύνδεσμο:",
            tags$a(href = "https://covid19.csd.auth.gr/","CovidDEXP Global"),
            " είναι επίσης διαθέσιμη και μία εκδοχή της πλατφόρμας που
            περιλαμβάνει δεδομένα κι αναλύσεις σε παγκόσμιο επίπεδο.",
            h3("Πηγές δεδομένων"),
            "Το έργο αυτό συγκεντρώνει και συνδυάζει δημόσια διαθέσιμα δεδομένα από
            διαφορετικές πηγές. Σ'αυτές περιλαμβάνονται:",
            tags$ul(
              tags$li(tags$b("Δεδομένα εξάπλωσης του COVID-19 στην Ελλάδα:"),
                      tags$a(href = "https://www.covid19response.gr/",
                             "COVID-19 Response Greece")),
              tags$li(tags$b("Ιστοσελίδα της Ελληνικής Κυβέρνησης για την
                             εξάπλωση του κορονωϊού:"),
                      tags$a(href = "https://covid19.gov.gr",
                             "covid19.gov.gr")),
              tags$li(tags$b("Δεδομένα COVID-19:"),
                      tags$a(href = "https://github.com/CSSEGISandData/COVID-19",
                             "Johns Hopkins CSSE")),
              tags$li(tags$b("Κατά περιοχή δεδομένα εξάπλωσης του κορονωϊου
                             στην Ελλάδα:"),
                      tags$a(href = "https://github.com/Sandbird/covid19-Greece",
                             "αποθετήριο δεδομένων JSON Sandbird")),
              tags$li(tags$b("Δεδομένα λήψης μέτρων:"),
                      tags$a(href = "https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker",
                             "Oxford COVID-19 Government Response Tracker")),
            ),
            h3("Σύνδεσμοι προς αυτή τη σελίδα"),
            "Μπορείτε να συνδεθείτε σε αυτήν τη σελίδα χρησιμοποιώντας το κύριο της σύνδεσμο:",
            tags$a(href = "https://covid19.csd.auth.gr/greece",
                   "https://covid19.csd.auth.gr/greece"),
            br(),br(),
            "Μπορείτε επίσης να χρησιμοποιήσετε συνδέσμους για οποιαδήποτε από
            τις διαθέσιμες υποσελίδες:",
            tags$ul(
              tags$li(tags$b("Συνοπτικά:"),
                      tags$a(href = "https://covid19.csd.auth.gr/greece/?tab=greece",
                             "https://covid19.csd.auth.gr/greece/?tab=greece")),
              tags$li(tags$b("Γραφήματα:"),
                      tags$a(href = "https://covid19.csd.auth.gr/greece/?tab=plots",
                             "https://covid19.csd.auth.gr/greece/?tab=plots")),
              tags$li(tags$b("Μέτρα:"),
                      tags$a(href = "https://covid19.csd.auth.gr/greece/?tab=measures",
                             "https://covid19.csd.auth.gr/greece/?tab=measures")),
              tags$li(tags$b("Twitter:"),
                      tags$a(href = "https://covid19.csd.auth.gr/greece/?tab=twitter",
                             "https://covid19.csd.auth.gr/greece/?tab=twitter")),
              tags$li(tags$b("Σχετικά με την ιστοσελίδα:"),
                      tags$a(href = "https://covid19.csd.auth.gr/greece/?tab=about",
                             "https://covid19.csd.auth.gr/greece/?tab=about")),
            ),
            h3("Προτάσεις και ζητήματα"),
            "Αν αντιμετωπίζετε το οποιοδήποτε ζήτημα ή αν έχει πρότάσεις για
            την βελτίωση και προσθήκη νέου περιεχομένου, μπορείτε να
            δημιουργήσετε ένα νέο ζήτημα",
            tags$a(href = "https://github.com/Datalab-AUTH/covid19_dashboard_greece/issues",
                   "στον ανιχνευτή ζητημάτων μας στο GitHub (Issue Tracker)."),
            h3("Η Ομάδα"),
            tags$ul(
              tags$li("Καθηγήτρια Αθηνά Βακάλη - Διευθύντρια του εργαστηρίου επιστήμης δεδομένων και Παγκόσμιου Ιστού"),
              tags$li("Βασίλειος Ψωμιάδης - Μεταδιδακτορικός ερευνητής"),
              tags$li("Γεώργιος Αρβανιτάκης - Μεταδιδακτορικός ερευνητής"),
              tags$li("Παύλος Σερμπέζης - Μεταδιδακτορικός ερευνητής"),
              tags$li("Ηλίας Δημητριάδης - υπ.Διδάκτορας - ερευνητής"),
              tags$li("Στέφανος Ευσταθίου - υπ.Διδάκτορας - ερευνητής"),
              tags$li("Δήμητρα Καρανάτσιου - υπ.Διδάκτορας - ερευνητής"),
              tags$li("Μαρίνος Ποιητής - υπ.Διδάκτορας - ερευνητής"),
              tags$li("Γιώργος Βλαχάβας - υπ.Διδάκτορας - ερευνητής"),
              tags$li("Σοφία Υφαντίδου - υπ.Διδάκτορας - ερευνητής"),
              tags$li("Κωνσταντίνος Γεωργίου - Μεταπτυχιακός φοιτητής")
            ),
            h3("Αδειοδότηση"),
            "Οι δημιουργοί της συγκεκριμένης πρωτοβουλίας είναι υπέρμαχοι της
            νοοτροπίας ανοιχτού κώδικα και πηγών δεδομένων καθώς και
            των θεμελιωδών οφελών του στην ανοιχτή επιστημονική έρευνα.
            Αυτή η προσπάθεια χρησιμοποιεί ανοιχτά σύνολα δεδομένων, βασίζεται
            σε τεχνολογίες ανοιχτού κώδικα και κυκλοφορεί στο κοινό με άδεια
            πνευματικών δικαιωμάτων",
            tags$a(href = "https://en.wikipedia.org/wiki/MIT_License",
                   "MIT license."),
            "Μπορείτε να βρείτε όλο τον σχετικό πηγαίο κώδικα στη σελίδα του
            έργου μας στο",
            tags$a(href = "https://github.com/Datalab-AUTH/covid19_dashboard_greece/",
                   "Github."),
            width = 12,
            style = "padding-left: 20px; padding-right: 20px; padding-bottom: 40px; margin-top: -15px;"
          ),
          width = 6,
        ),
        width = 12,
        style = "padding: 15px"
      )
    )
  )
)

page_about <- dashboardPage(
  title   = "Σχετικά με την ιστοσελίδα",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_about
)
