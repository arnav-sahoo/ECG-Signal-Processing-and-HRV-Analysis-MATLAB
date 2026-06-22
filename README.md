# ECG Signal Processing and HRV Analysis using MATLAB

## Overview
This project presents a MATLAB-based ECG signal processing and heart rate variability (HRV) analysis workflow using an open-source ECG record from the MIT-BIH Arrhythmia Database. The objective was to preprocess a raw ECG signal, remove common sources of noise and interference, detect physiologically relevant R-peaks, and extract time-domain HRV metrics such as SDNN and RMSSD.

The project combines:
- ECG signal preprocessing
- frequency-domain inspection
- R-peak detection
- RR interval extraction
- heart rate estimation
- time-domain HRV analysis



## Objective
The main goals of this project were to:

- import and visualize a raw ECG record in MATLAB
- preprocess the ECG signal using filtering techniques
- remove baseline wander, high-frequency noise, and power-line interference
- preserve ECG morphology while improving signal quality
- detect R-peaks automatically
- compute RR intervals and heart rate
- perform time-domain HRV analysis using SDNN and RMSSD



## Dataset
- **Source:** MIT-BIH Arrhythmia Database
- **Record used:** 100
- **Sampling frequency:** 360 Hz
- **Signal duration:** ~30 minutes

The raw ECG data was first downloaded from PhysioNet / MIT-BIH, converted into a readable `.csv` format using Python and terminal-based processing, and then imported into MATLAB for analysis.



## Project Workflow

### Phase 1: ECG Signal Import and Preprocessing
1. Downloaded open-source ECG signals from the MIT-BIH Arrhythmia Database
2. Converted the raw record into a MATLAB-readable `.csv` file
3. Imported the signal into MATLAB and resolved toolbox / directory setup issues
4. Visualized the ECG in the time domain and configured sample rate and time units
5. Selected a representative 10-beat region of interest for filtering validation
6. Applied ECG preprocessing filters:
   - **High-pass filter (0.5 Hz)** to remove baseline wander
   - **Low-pass filter (40 Hz)** to suppress high-frequency noise
   - **Band-stop filter (59–61 Hz)** to remove 60 Hz power-line interference
7. Verified that ECG morphology was preserved after filtering
8. Recomputed average RR interval and heart rate after filtering

### Phase 2: R-Peak Detection and HRV Analysis
1. Exported the processed ECG signal from MATLAB Signal Analyzer
2. Used MATLAB code to detect R-peaks from the final filtered ECG
3. Converted peak sample locations into time values
4. Computed RR intervals across the full ECG record
5. Estimated average heart rate
6. Performed time-domain HRV analysis using:
   - **SDNN**: Standard Deviation of Normal-to-Normal Intervals
   - **RMSSD**: Root Mean Square of Successive Differences



## ECG Preprocessing Pipeline
The ECG preprocessing pipeline consisted of:

- **High-pass filter (0.5 Hz)**  
  Used to remove baseline wander caused by breathing, motion, and slow drift.

- **Low-pass filter (40 Hz)**  
  Used to suppress high-frequency noise and muscle-related interference.

- **Band-stop filter (59–61 Hz)**  
  Used in place of a dedicated notch filter to suppress 60 Hz power-line interference present in the US-recorded dataset.

Higher-order harmonics were not separately filtered because they were already sufficiently attenuated by the low-pass stage.



## Peak Detection Parameter Validation
A sensitivity analysis was performed on the peak detection algorithm to study the effect of threshold settings.

When the detection parameters were relaxed from:
- `MinPeakHeight = 0.8`
- `MinPeakDistance = 200`

to:
- `MinPeakHeight = 0`
- `MinPeakDistance = 20`

the number of detected peaks increased from **2265** to **9966**.

This demonstrated that the tuned threshold settings effectively suppressed false detections arising from P waves, T waves, and residual noise while preserving physiologically relevant R-peaks.

---

## Results

### Heart Rate
- **Average RR interval before filtering:** ~0.81 s
- **Average heart rate before filtering:** 74.07 BPM
- **Average heart rate after filtering:** 73.87 BPM

The negligible change in estimated heart rate before and after filtering suggests that the filtering pipeline improved signal quality without distorting the underlying physiological rhythm.

### HRV Metrics
Time-domain HRV analysis on the filtered ECG yielded:

- **SDNN = 59 ms**
- **RMSSD = 73.9 ms**
- **Average Heart Rate = 73.9 BPM**

### Interpretation
The average heart rate of 73.9 BPM is consistent with a normal resting rhythm for this ECG record.

An **SDNN of 59 ms** indicates a normal level of overall beat-to-beat variability across the recording, suggesting the presence of natural fluctuations in cardiac rhythm rather than an excessively rigid heart rate pattern.

An **RMSSD of 73.9 ms** indicates a reasonable amount of short-term beat-to-beat variability, reflecting meaningful variation in consecutive RR intervals and demonstrating that the extracted ECG features capture physiological information beyond average heart rate alone.

> Note: These HRV values are interpreted only as signal-analysis results for this dataset and are not intended as a clinical diagnosis.

---

## MATLAB Scripts

### `scripts/Day1_Raw_ECG.m`
Contains:
- ECG import
- raw ECG plotting
- initial visualization and exploration of the signal

### `scripts/ECG_HRV_Analysis.m`
Contains:
- loading the processed ECG signal
- R-peak detection using `findpeaks`
- RR interval extraction
- average heart rate calculation
- SDNN and RMSSD calculation
- RR interval tachogram and histogram generation

---

## MATLAB Documentation

### `docs/ECG_Filtering_Workflow.mldatx`  
MATLAB Signal Analyzer workflow file containing the ECG preprocessing pipeline, intermediate filtering stages, and figure generation workflow.

---

## Repository Structure

```text
ECG-Signal-Processing-and-HRV-Analysis-MATLAB/
│
├── README.md
├── scripts/
│   ├── Day1_Raw_ECG.m
│   └── ECG_HRV_Analysis.m
│
├── data/
│   ├── ecg100.csv
│   └── ProcessedSignals.mat
│
├── figures/
│   ├── 01_raw_ecg_full_signal.png
│   ├── 02_raw_ecg_first_2000_samples.png
│   ├── 04_filtered_ecg_full_signal.png
│   ├── 05_filtered_ecg_first_2000_samples.png
│   ├── 06_detected_r_peaks.png
│   ├── 07_effect_of_peak_detection_threshold.png
│   ├── 08_rr_interval_tachogram.png
│   ├── 09_rr_interval_histogram.png
│   │
│   └── signal_analyzer_filtering_workflow/
│       ├── 01_raw_ecg_roi_with_peak_annotations
│       ├── 02_lowpass_filter_output.png
│       ├── 03_lowpass_highpass_filter_output
│       ├── 04_lowpass_highpass_notch_filter_output
│       ├── 05_final_filtered_ecg_with_r_peak_annotations
│       ├── 06_raw_to_lowpass_comparison
│       ├── 07_raw_to_lp_to_hp_comparison
│       ├── 08_full_filtering_pipeline_comparison
│       └── 09_raw_vs_final_filtered_comparison
│
└── docs/
    └── ECG_Filtering_Workflow.mldatx
```
  
---

## Figures

Figure set for this repository:

### Main project figures

1. Raw ECG full signal  
   `figures/01_raw_ecg_full_signal.png`

2. Raw ECG first 2000 samples  
   `figures/02_raw_ecg_first_2000_samples.png`

3. Filtered ECG full signal  
   `figures/04_filtered_ecg_full_signal.png`

4. Filtered ECG first 2000 samples  
   `figures/05_filtered_ecg_first_2000_samples.png`

5. Detected R-peaks on filtered ECG  
   `figures/06_detected_r_peaks.png`

6. Effect of peak detection threshold on ECG feature extraction  
   `figures/07_effect_of_peak_detection_threshold.png`

7. RR interval tachogram  
   `figures/08_rr_interval_tachogram.png`

8. RR interval histogram  
   `figures/09_rr_interval_histogram.png`

### Signal Analyzer filtering workflow figures

9. Raw ECG ROI with peak annotations  
   `figures/signal_analyzer_filtering_workflow/01_raw_ecg_roi_with_peak_annotations.png`

10. Low-pass filter output  
    `figures/signal_analyzer_filtering_workflow/02_lowpass_filter_output.png`

11. Low-pass + high-pass filter output  
    `figures/signal_analyzer_filtering_workflow/03_lowpass_highpass_filter_output.png`

12. Low-pass + high-pass + notch filter output  
    `figures/signal_analyzer_filtering_workflow/04_lowpass_highpass_notch_filter_output.png`

13. Final filtered ECG with R-peak annotations  
    `figures/signal_analyzer_filtering_workflow/05_final_filtered_ecg_with_r_peak_annotations.png`

14. Raw to low-pass comparison  
    `figures/signal_analyzer_filtering_workflow/06_raw_to_lowpass_comparison.png`

15. Raw to low-pass to high-pass comparison  
    `figures/signal_analyzer_filtering_workflow/07_raw_to_lp_to_hp_comparison.png`

16. Full filtering pipeline comparison  
    `figures/signal_analyzer_filtering_workflow/08_full_filtering_pipeline_comparison.png`

17. Raw vs final filtered comparison  
    `figures/signal_analyzer_filtering_workflow/09_raw_vs_final_filtered_comparison.png`

---

## References
The HRV interpretation used in this project was informed by commonly cited standards and literature, including:

- Task Force of the European Society of Cardiology and the North American Society of Pacing and Electrophysiology, **Heart Rate Variability: Standards of Measurement, Physiological Interpretation, and Clinical Use**, 1996
- Malik et al., HRV standards and biomedical signal processing literature

---

## Future Improvements
Possible next extensions of this project include:

- frequency-domain HRV analysis (LF/HF power)
- implementing a dedicated QRS detection algorithm instead of relying only on `findpeaks`
- comparing HRV features across multiple MIT-BIH records
- automated ECG denoising and arrhythmia-oriented feature extraction
- integration of ECG analytics into a real-time biomedical monitoring dashboard
