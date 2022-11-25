cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 5
  maskT2:
    type: File
    inputBinding:
      position: 4
  firstOrderFit: 
    type: File
    inputBinding:
      position: 3
  t2p_nii: 
    type: Directory
    inputBinding:
      position: 2      
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/09_brainMask.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  rdfMask:
    type: File
    outputBinding:
      glob: "rdf_mask.nii.gz"
  qsmMask:
    type: File
    outputBinding:
      glob: "qsmIn_mask"


