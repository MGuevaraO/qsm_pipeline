cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 6
  segmentation:
    type: Directory
    inputBinding:
      position: 5
  t2p_nii: 
    type: Directory
    inputBinding:
      position: 4   
  r2star: 
    type: File
    inputBinding:
      position: 3
  QSM: 
    type: File
    inputBinding:
      position: 2    
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/13_extractROIvalues.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  QSM_ROIvalues:
    type: File
    outputBinding:
      glob: "qsm_report.csv"
  R2_ROIvalues:
    type: File
    outputBinding:
      glob: "r2star_report.csv"

