cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 7
  r2ROIval: 
    type: File
    inputBinding:
      position: 6   
  qsmROIval: 
    type: File
    inputBinding:
      position: 5   
  r2star: 
    type: File
    inputBinding:
      position: 4
  QSM: 
    type: File
    inputBinding:
      position: 3
  fileName:
    type: File
    inputBinding:
      position: 2    
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/14_zipResults.py
  

outputs:
  zipFileOut:
    type: File
    outputBinding:
      glob: "*.tar.gz"

