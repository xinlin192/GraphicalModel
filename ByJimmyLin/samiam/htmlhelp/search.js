    ttl = new Object();
    desc = new Object();
    keys = new Object();
    links= new Object();    
    matched= new Object();    
    kwords= new Object();
    found= new Object();
    temp=0;
    kwords[0]=0;
    found[0]=0;
    output = '';

    function search() {

        temp=0;
        kwords[0]=0;
        found[0]=0;
        output = '';
        do_search();
        // show_output();


        return false;
    }


    function do_search(){

        var skeyword=document.searchengine.keywords.value.toLowerCase();
        var check=1;
        var pos=0;
        var i=0;
        var j=0;
        var itemp=0;
        var config='';

        while (true) {
            if (skeyword.indexOf("+") == -1 ) {
                kwords[check]=skeyword;
                break;
            }
            pos=skeyword.indexOf("+");
            if (skeyword !="+")	 {
                kwords[check]=skeyword.substring(0,pos);
                check++;
            }
            else {
                check--;
                break;
            }
            skeyword=skeyword.substring(pos+1, skeyword.length);	
            if (skeyword.length ==0) {
                check--;
                break;
            }

        }

        // the keywords have been put in keywords object.
        kwords[0]=check;

        // matching and storing the matches in matched
        for ( i=1; i<=kwords[0];i++) {
            for (j=1;j<=num_titles;j++) {
                if ( keys[j].toLowerCase().indexOf(kwords[i]) > -1 || ttl[j].toLowerCase().indexOf(kwords[i]) > -1 || desc[j].toLowerCase().indexOf(kwords[i]) > -1) {
                    matched[j]++;
                }
            }	
        }


        // putting all the indexes of the matched records  in found
        for (i=1;i<=num_titles;i++) {
            if (matched[i] > 0 ) {
                found[0]++;
                // increment the found 	
                found[found[0]]=i;
            }	
        }



        for (i=1;i<=found[0]-1;i++) {
            for(j=i+1;j<=found[0];j++) {
                if ( matched[found[i]]< matched[found[j]] ) {
                    temp= found[j];
                    found[j]=found[i];
                    found[i]=temp;
                }
            }
        }

        // end of sort

        // SEARCH HEADER //
        output = output + 'Search Results for: <B>';    
        for (i=1;  i<=kwords[0]; i++) {
            output = output +  kwords[i].bold() + "   ";
        }
        output = output + '</B>';

        // No Results //
        if (found[0]==0) {
            output = output + "<HR><BR><BR><b>No matches resulted in this search </b> <br>";
            output = output + "You may close the results and reduce the length/number  of the keywords  <br>";
        }

        // Results Found //
        else {
            
            output = output + "[" + found[0] + "  Matches  " . italics();
            output = output + "]<HR><BR><OL>";

            for (i=1; i<=found[0];i++) {
                output = output + "<LI>";
                itemp=found[i];
                output = output + ttl[itemp].bold() + "<br>";
                output = output + desc[itemp] + "<br>";
                output = output + links[itemp].link(links[itemp])+"<br>";
                temp= (matched[itemp]/kwords[0])*100
                output = output + "<i>" +temp+" %  </i><P>" ;
                matched[itemp]=0
            } 
            found[0]=0;
            output = output + "</OL>";
        }

    }

    function show_output() {

            var NS4 = (document.layers) ? 1 : 0;
            var IE = (document.all) ? 1 : 0;
            var DOM = 0; 
            var Opera = 0;

            if (parseInt(navigator.appVersion) >=5) {DOM=1};

            if ( (navigator.userAgent.indexOf("Opera 6")!=-1) || (navigator.userAgent.indexOf("Opera/6")!=-1) ) {
                 DOM = 0;
                 IE = 0;
                 Opera = 1;
            }

            target=('SEARCHOUT');
               
                if (DOM || IE) {
                    var out = document.getElementById(target);
                    out.innerHTML = output;
                }
                    
                else if (NS4 || Opera) {
                    config='height=400,width=400,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes'
                    win = window.open ("","outputwindow",config)
                    win.document.open();
                    win.document.write(output);
                    win.document.close();
                }
                    
                // && (version >=4)
                else {
                    alert("get a real browser");
                }


            }
