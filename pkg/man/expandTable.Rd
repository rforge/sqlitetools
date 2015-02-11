\name{expandTable}
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
% Alias
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
\alias{expandTable}
\title{expandTable: Expands database rows into multiple database output rows. }
\description{Reads readTable and writes replicated and equally distributed
values into writeTable.}
\usage{
expandTable(dbfile, tables, boundCols, indexCol, copyCols, expandCols, verbose=FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dbfile}{character. Name of database file.}
  \item{tables}{character. Name of read table and write table.}
  \item{boundCols}{character. Name of boundary columns: 
    loBound and hiBound}
  \item{indexCol}{character. Name of index column which is written
    to output table.}
    \item{copyCols}{character. Name of columns which are copied.}
    \item{expandCols}{character. Name of columns which are expanded.}
    \item{verbose}{numeric. Verbosity of printed output.}
}
\details{The function expands 'indexCol' value for values between 
first and second boundCols value.}
\value{Integer. Number of rows inserted into output table.}
\author{Wolfgang Kaisers}
\examples{
n <- 5
v <- 1:n
dfr <- data.frame(id=v,
                exp1 = v * 100/7,
                exp2 = v * 200/7,
                cpy1 = letters[v],
                cpy2 = 2*v,
                min_woche = v*100 - 1,
                max_woche = v*100 + 1)

dbfile <- file.path(".", "test.db3")
tables <- c("tbl", "rtbl")
boundCols <- c("min_woche", "max_woche")
indexCol <- "woche"
copyCols <- c("cpy1", "cpy2")
expandCols <- c("exp1", "exp2")
verbose <- 1L


# Write SQLite database. Contains test data
con <- dbConnect(RSQLite::SQLite(), dbfile)
dbWriteTable(con, tables[1], dfr, overwrite=TRUE)
dbDisconnect(con)
# Do replicate
nr <- expandTable(dbfile, tables, boundCols, indexCol, copyCols, expandCols, verbose)
nr
}
\keyword{expandTable}
