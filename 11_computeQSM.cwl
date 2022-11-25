cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 6
  t2p:
    type: Directory
    inputBinding:
      position: 5
  t2a:
    type: Directory
    inputBinding:
      position: 4
  RDF: 
    type: File
    inputBinding:
      position: 3
  maskQSM: 
    type: File
    inputBinding:
      position: 2      
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/11_computeQSM.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  QSM:
    type: File
    outputBinding:
      glob: "qsm_custom_maskRdf.nii.gz"

