Lista TODO:


COMANDI GITHUB:

-) Vedere lo stato del progetto:
    git status

    Righe rosse: modifiche non confermate
    Righe verdi: modifiche confermate

-) Confermare una modifica:
    git add FILEPATH
    FILEPATH: path del file modificato da confermare, oppure il punto per confermare tutte le modifiche fatte

-) Impacchettare le modifiche confermate:
    git commit -m "MESSAGGIO"
    
-) Mandare in remoto sulla propria fork il pacchetto:
    git push origin master

-) Creare una pull request:
    Tornare sul github del progetto globale (di ffoglia9), "New pull request", "compare across forks", cambiare head repository con la propria fork. Poi creare la pull request.

-) Aggiornare il proprio progetto locale:
    Da git bash, settare la mia repository come upstream: git remote add upstream https://github.com/ffoglia9/TSWGameUpProject
    Poi eseguire un rebase: git rebase upstream/master
    Ed infine aggiornare la propria repository remota: git push
    Poi potete iniziare a modificare il progetto. Fatelo prima di fare qualsiasi modifica, altrimenti potreste causare un merge conflict.