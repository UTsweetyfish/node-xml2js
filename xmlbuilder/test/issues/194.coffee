suite 'Tests specific to issues:', ->
  test 'Proper line breaks on Windows? (\r\n in text nodes). Issue 194', ->

    escapeFunc = (str) ->
      str.replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/\r/g, '&#xD;')
        .replace(/\r?\n/gm, '\r\n') # normalize newlines

    eq(
      xml('root', { headless: true, stringify: { textEscape: escapeFunc } })
        .ele("foo", "line\nbreak")
      .end( { pretty: true, newline: "\r\n" } )

      '<root>\r\n' +
      '  <foo>line\r\nbreak</foo>\r\n' +
      '</root>'
    )
