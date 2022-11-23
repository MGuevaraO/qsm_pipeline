#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow


inputs:
  zipFile: string
  brainTemplate: 
    type: File
    default:
      class: File
      location: ./Oasis_Template/T_template0.nii.gz
  brainProbMask: 
    type: File
    default:
      class: File
      location: ./Oasis_Template/T_template0_BrainCerebellumProbabilityMask.nii.gz

outputs:
  logFile:
    type: File
    outputSource: concatenate_echoes/log
  b1:
    type: Directory
    outputSource: convert_nifti/b1_nii
  t1:
    type: Directory
    outputSource: convert_nifti/t1_nii
  segmentation:
    type: Directory
    outputSource: unzip_files/segmentation
  t2a_c:
    type: File
    outputSource: concatenate_echoes/t2a_c
  t2p_c:
    type: File
    outputSource: concatenate_echoes/t2p_c
  brainMaskT2:
    type: File
    outputSource: brain_extraction_reg/brainMaskT2
    
    
steps:    
  unzip_files:
    run: 01_unzip.cwl
    in:
      zipFileIn: zipFile
    out: [log, b1, t1, t2a, t2p, segmentation]

  convert_nifti:
    run: 02_convertNifti.cwl
    in:
      b1_dcm: unzip_files/b1
      t1_dcm: unzip_files/t1
      t2a_dcm: unzip_files/t2a
      t2p_dcm: unzip_files/t2p
    out: [log, b1_nii, t1_nii, t2a_nii, t2p_nii]
     
  concatenate_echoes:
    run: 03_concatenateEchoes.cwl
    in:
      t2a_nii_i: convert_nifti/t2a_nii
      t2p_nii_i: convert_nifti/t2p_nii
    out: [log, t2a_c, t2p_c]

  brain_extraction_reg:
    run: 04_brainExtractionAndRegistration.cwl
    in:
      brain_prob_mask: brainProbMask
      brain_template: brainTemplate
      t2m_nii: convert_nifti/t2a_nii
      t1_nii: convert_nifti/t1_nii
    out: [log, brainMaskT2] 

  phase_Laplacian_error:
    run: 05_phaseLaplacianError.cwl
    in:
      ce_mag: concatenate_echoes/t2a_c
    out: [log, eres] 

  phase_Laplacian:
    run: 06_phaseLaplacian.cwl
    in:
      ce_phase: concatenate_echoes/t2p_c
    out: [log, lap] 

  laplacian_sum:
    run: 07_laplacianSum.cwl
    in:
      t2a_nii_i: convert_nifti/t2a_nii
      t2p_nii_i: convert_nifti/t2p_nii
      lapFile: phase_Laplacian/lap
      eresFile: phase_Laplacian_error/eres
    out: [log, lapSum, lapW] 

  phase_gradient:
    run: 08_phaseGradient.cwl
    in: 
      t2p_nii_i: convert_nifti/t2p_nii
      eresFile: phase_Laplacian_error/eres
      ce_phase: concatenate_echoes/t2p_c
    out: [log, gampFile, fstOrderFit] 

  brain_mask:
    run: 09_brainMask.cwl
    in:
      maskT2: brain_extraction_reg/brainMaskT2
      ffoW1File_i: phase_gradient/fstOrderFit
      t2p_nii_i: convert_nifti/t2p_nii
    out: [log, rdfMask, qsmMask] 