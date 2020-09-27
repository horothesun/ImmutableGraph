FROM swift:5.3

WORKDIR /package

COPY . ./

CMD swift test
