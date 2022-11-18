#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow


inputs:
  zipFile: string
  
outputs:
  logFile:
    type: File
    outputSource: convert_nifti/log
  b1:
    type: Directory
    outputSource: convert_nifti/b1_n
  t1:
    type: Directory
    outputSource: convert_nifti/t1_n
  t2_am:
    type: Directory
    outputSource: convert_nifti/t2_am_n
  t2_ph:
    type: Directory
    outputSource: convert_nifti/t2_ph_n
  segmentation:
    type: Directory
    outputSource: unzip_files/segmentation

    
    
steps:    
  unzip_files:
    run: 01_unzip.cwl
    in:
      zipFileIn: zipFile
    out: [log, b1, t1, t2_am, t2_ph, segmentation]
  convert_nifti:
    run: 02_convertNifti.cwl
    in:
      b1_d: unzip_files/b1
      t1_d: unzip_files/t1
      t2_am_d: unzip_files/t2_am
      t2_ph_d: unzip_files/t2_ph
    out: [log, b1_n, t1_n, t2_am_n, t2_ph_n]
     

