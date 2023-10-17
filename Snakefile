configfile: "config.yaml"
TEMPLATE_REPOSITORY = config["TEMPLATE_REPOSITORY"]

LECTURES = ['neocortex_tetzlaff_20231019']            

rule all:
    input:
        expand("{lecture}.pdf", lecture=LECTURES)
        
rule compile:    
    input:
        '{lecture}.tex',
        'inm6-templates/talk/latex_official'    
    output:
        '{lecture}.pdf'
    run:
        file_root = input[0][:-4]
        shell('export TEXINPUTS=$TEXINPUTS:inm6-templates/talk/latex_official ; pdflatex {input[0]} ; bibtex {file_root} ; pdflatex {input[0]}')
        
rule clone_template:
    output:
        directory('inm6-templates')
    run:
        shell('git clone {TEMPLATE_REPOSITORY}')
  
rule clean:
    run:
        shell("rm -f *~ *.log *.aux *.bbl *.blg *.idx *.ilg *.ind *.lof *.out *.pfg *.toc *.soc *.nav *.snm *.bcf *.xml *blx.bib")
