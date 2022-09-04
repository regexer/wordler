Wordler can help you cheat at Wordle, if that's what you're into.

This simple web service accepts up to 5 letters and returns the valid words those letters occur in.

start it like this:
```sh
bundle exec rackup
```

call it like this
```sh
curl http://localhost:9292/words.json\?letters=LA_ER
```

JSON Result:
```json
{"positional":true,"words":["LACER","LADER","LAGER","LAKER","LAMER","LASER","LATER","LAVER","LAWER","LAXER","LAYER"]}
```

For non-positional results
```sh
curl http://localhost:9292/words.json\?letters=LAER&positional=false
```

JSON Result:
```json
{"positional":"false","words":["ABLER","ALDER","ALERT","ALLER","ALTER","ALURE","AREAL","ARGLE","ARIEL","ARLED","ARLES","ARTEL","BALER","BELAR","BLAER","BLARE","BLEAR","CARLE","CLEAR","EARLS","EARLY","FARLE","FERAL","FLARE","GLARE","HALER","LACER","LADER","LAERS","LAGER","LAKER","LAMER","LAREE","LARES","LARGE","LASER","LATER","LAVER","LAWER","LAXER","LAYER","LEARE","LEARN","LEARS","LEARY","LEEAR","LEPRA","MAERL","MARLE","NERAL","PALER","PARLE","PEARL","RAILE","RALES","RATEL","RAVEL","RAYLE","REALM","REALO","REALS","RECAL","REGAL","RELAX","RELAY","RENAL","REPLA","SERAL","TALER","UREAL","VELAR","WALER"]}
```

