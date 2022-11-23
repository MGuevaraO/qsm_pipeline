cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 6
  brain_prob_mask: 
    type: File
    inputBinding:
      position: 5
  brain_template: 
    type: File
    inputBinding:
      position: 4
  t2m_nii: 
    type: Directory
    inputBinding:
      position: 3
  t1_nii: 
    type: Directory
    inputBinding:
      position: 2      
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/04_brainExtractionAndRegistration.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  brainMaskT2:
    type: File
    outputBinding:
      glob: "BrainExtractionMask_to_T2.nii.gz"

