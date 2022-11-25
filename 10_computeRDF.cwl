cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 6
  t2p_nii:
    type: Directory
    inputBinding:
      position: 5
  lapW:
    type: File
    inputBinding:
      position: 4
  rdfMask: 
    type: File
    inputBinding:
      position: 3
  lapSum: 
    type: File
    inputBinding:
      position: 2      
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/10_computeRDF.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  RDF:
    type: File
    outputBinding:
      glob: "qsmIn_rdf"

