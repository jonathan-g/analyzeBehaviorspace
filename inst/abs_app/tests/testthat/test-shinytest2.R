library(shinytest2)

test_that("{shinytest2} recording: Butterfly Corridor", {
  app <- AppDriver$new(variant = platform_variant(), name = "Butterfly Corridor",
      seed = 12345678, height = 1009, width = 1167)
  app$upload_file(file1 = "test_data/butterfly_small-experiment-table.csv")
  app$expect_values()
  app$set_inputs(ren_from = "corridor_width")
  app$set_inputs(ren_to = "C")

@@ -1,911 +0,0 @@
Stage chunk

Discard chunk

1

{
2

  "input": {
3

    ".clientValue-default-plotlyCrosstalkOpts": {
4

      "on": "plotly_click",
5

      "persistent": false,
6

      "dynamic": false,
7

      "selectize": false,
8

      "opacityDim": 0.2,
9

      "selected": {
10

        "opacity": 1
11

      },
12

      "debounce": 0,
13

      "color": [
14

15

      ]
16

    },
17

    "error_bars": "none",
18

    "file1": {
19

      "name": [
20

        "butterfly_small-experiment-table.csv"
21

      ],
22

      "size": [
23

        3396
24

      ],
25

      "type": [
26

        "text/csv"
27

      ],
28

      "datapath": [
29

        "0.csv"
30

      ]
31

    },
32

    "group_var": "q",
33

    "last_tick": true,
34

    "lines": true,
35

    "plotly_afterplot-A": "\"plot\"",
36

    "points": true,
37

    "quit_button": 0,
38

    "ren_from": "mean_elevation_of_turtles",
39

    "ren_to": "",
40

    "rename": 2,
41

    "summary_tab": true,
42

    "table_cell_clicked": {
43

44

    },
45

    "table_cells_selected": [
46

47

    ],
48

    "table_columns_selected": null,
49

    "table_rows_all": [
50

      1,
51

      2,
52

      3,
53

      4,
54

      5,
55

      6,
56

      7,
57

      8,
58

      9,
59

      10,
60

      11,
61

      12,
62

      13,
63

      14,
64

      15,
65

      16,
66

      17,
67

      18,
68

      19,
69

      20,
70

      21,
71

      22,
72

      23,
73

      24,
74

      25,
75

      26,
76

      27,
77

      28,
78

      29,
79

      30,
80

      31,
81

      32,
82

      33,
83

      34,
84

      35,
85

      36,
86

      37,
87

      38,
88

      39,
89

      40,
90

      41,
91

      42,
92

      43,
93

      44,
94

      45,
95

      46,
96

      47,
97

      48,
98

      49,
99

      50
100

    ],
101

    "table_rows_current": [
102

      1,
103

      2,
104

      3,
105

      4,
106

      5,
107

      6,
108

      7,
109

      8,
110

      9,
111

      10
112

    ],
113

    "table_rows_selected": null,
114

    "table_search": "",
115

    "table_state": {
116

      "start": 0,
117

      "length": 10,
118

      "order": [
119

120

      ],
121

      "search": {
122

        "search": "",
123

        "smart": true,
124

        "regex": false,
125

        "caseInsensitive": true
126

      },
127

      "columns": [
128

        {
129

          "visible": true,
130

          "search": {
131

            "search": "",
132

            "smart": true,
133

            "regex": false,
134

            "caseInsensitive": true
135

          }
136

        },
137

        {
138

          "visible": true,
139

          "search": {
140

            "search": "",
141

            "smart": true,
142

            "regex": false,
143

            "caseInsensitive": true
144

          }
145

        },
146

        {
147

          "visible": true,
148

          "search": {
149

            "search": "",
150

            "smart": true,
151

            "regex": false,
152

            "caseInsensitive": true
153

          }
154

        },
155

        {
156

          "visible": true,
157

          "search": {
158

            "search": "",
159

            "smart": true,
160

            "regex": false,
161

            "caseInsensitive": true
162

          }
163

        },
164

        {
165

          "visible": true,
166

          "search": {
167

            "search": "",
168

            "smart": true,
169

            "regex": false,
170

            "caseInsensitive": true
171

          }
172

        }
173

      ]
174

    },
175

    "x_var": "corridor_width",
176

    "y_var": "mean_elevation_of_turtles"
177

  },
178

  "output": {
179

    "plot": {
180

      "x": {
181

        "data": [
182

          {
183

            "x": [
184

              717.724504230916,
185

              725.884126485352,
186

              727.08335402851,
187

              735.754285651947,
188

              743.582194521975,
189

              745.683678814475,
190

              746.747959676358,
191

              747.891607941182,
192

              749.77527795676,
193

              781.914269402679
194

            ],
195

            "y": [
196

              543.8348,
197

              544.65,
198

              545.1694,
199

              543.8162,
200

              543.8404,
201

              543.396,
202

              541.6984,
203

              545.3948,
204

              547.6558,
205

              545.7582
206

            ],
207

            "text": [
208

              "corridor_width: 717.7245<br />mean_elevation_of_turtles: 543.8348<br />ordered(q): 0<br />ordered(q): 0",
209

              "corridor_width: 725.8841<br />mean_elevation_of_turtles: 544.6500<br />ordered(q): 0<br />ordered(q): 0",
210

              "corridor_width: 727.0834<br />mean_elevation_of_turtles: 545.1694<br />ordered(q): 0<br />ordered(q): 0",
211

              "corridor_width: 735.7543<br />mean_elevation_of_turtles: 543.8162<br />ordered(q): 0<br />ordered(q): 0",
212

              "corridor_width: 743.5822<br />mean_elevation_of_turtles: 543.8404<br />ordered(q): 0<br />ordered(q): 0",
213

              "corridor_width: 745.6837<br />mean_elevation_of_turtles: 543.3960<br />ordered(q): 0<br />ordered(q): 0",
214

              "corridor_width: 746.7480<br />mean_elevation_of_turtles: 541.6984<br />ordered(q): 0<br />ordered(q): 0",
215

              "corridor_width: 747.8916<br />mean_elevation_of_turtles: 545.3948<br />ordered(q): 0<br />ordered(q): 0",
216

              "corridor_width: 749.7753<br />mean_elevation_of_turtles: 547.6558<br />ordered(q): 0<br />ordered(q): 0",
217

              "corridor_width: 781.9143<br />mean_elevation_of_turtles: 545.7582<br />ordered(q): 0<br />ordered(q): 0"
218

            ],
219

            "type": "scatter",
220

            "mode": "lines+markers",
221

            "line": {
222

              "width": 1.88976377952756,
223

              "color": "rgba(248,118,109,1)",
224

              "dash": "solid"
225

            },
226

            "hoveron": "points",
227

            "name": "0",
228

            "legendgroup": "0",
229

            "showlegend": true,
230

            "xaxis": "x",
231

            "yaxis": "y",
232

            "hoverinfo": "text",
233

            "marker": {
234

              "autocolorscale": false,
235

              "color": "rgba(248,118,109,1)",
236

              "opacity": 1,
237

              "size": 5.66929133858268,
238

              "symbol": "circle",
239

              "line": {
240

                "width": 1.88976377952756,
241

                "color": "rgba(248,118,109,1)"
242

              }
243

            },
244

            "frame": null
245

          },
246

          {
247

            "x": [
248

              525.217496103159,
249

              537.806072522712,
250

              539.202378634217,
251

              541.345189620861,
252

              543.228585661109,
253

              546.455151381655,
254

              546.735904387545,
255

              559.814896396004,
256

              563.457988403085,
257

              563.56463657676
258

            ],
259

            "y": [
260

              618.748399999999,
261

              617.3564,
262

              613.240800000001,
263

              617.6274,
264

              616.3764,
265

              616.9568,
266

              617.4932,
267

              616.8416,
268

              618.1866,
269

              617.247200000001
270

            ],
271

            "text": [
272

              "corridor_width: 525.2175<br />mean_elevation_of_turtles: 618.7484<br />ordered(q): 0.25<br />ordered(q): 0.25",
273

              "corridor_width: 537.8061<br />mean_elevation_of_turtles: 617.3564<br />ordered(q): 0.25<br />ordered(q): 0.25",
274

              "corridor_width: 539.2024<br />mean_elevation_of_turtles: 613.2408<br />ordered(q): 0.25<br />ordered(q): 0.25",
275

              "corridor_width: 541.3452<br />mean_elevation_of_turtles: 617.6274<br />ordered(q): 0.25<br />ordered(q): 0.25",
276

              "corridor_width: 543.2286<br />mean_elevation_of_turtles: 616.3764<br />ordered(q): 0.25<br />ordered(q): 0.25",
277

              "corridor_width: 546.4552<br />mean_elevation_of_turtles: 616.9568<br />ordered(q): 0.25<br />ordered(q): 0.25",
278

              "corridor_width: 546.7359<br />mean_elevation_of_turtles: 617.4932<br />ordered(q): 0.25<br />ordered(q): 0.25",
279

              "corridor_width: 559.8149<br />mean_elevation_of_turtles: 616.8416<br />ordered(q): 0.25<br />ordered(q): 0.25",
280

              "corridor_width: 563.4580<br />mean_elevation_of_turtles: 618.1866<br />ordered(q): 0.25<br />ordered(q): 0.25",
281

              "corridor_width: 563.5646<br />mean_elevation_of_turtles: 617.2472<br />ordered(q): 0.25<br />ordered(q): 0.25"
282

            ],
283

            "type": "scatter",
284

            "mode": "lines+markers",
285

            "line": {
286

              "width": 1.88976377952756,
287

              "color": "rgba(163,165,0,1)",
288

              "dash": "solid"
289

            },
290

            "hoveron": "points",
291

            "name": "0.25",
292

            "legendgroup": "0.25",
293

            "showlegend": true,
294

            "xaxis": "x",
295

            "yaxis": "y",
296

            "hoverinfo": "text",
297

            "marker": {
298

              "autocolorscale": false,
299

              "color": "rgba(163,165,0,1)",
300

              "opacity": 1,
301

              "size": 5.66929133858268,
302

              "symbol": "circle",
303

              "line": {
304

                "width": 1.88976377952756,
305

                "color": "rgba(163,165,0,1)"
306

              }
307

            },
308

            "frame": null
309

          },
310

          {
311

            "x": [
312

              465.365393822483,
313

              475.77472755803,
314

              483.678916684272,
315

              484.785385700541,
316

              485.88630271027,
317

              491.870381629307,
318

              500.02976429877,
319

              501.124862791005,
320

              506.334946729052,
321

              509.13832021343
322

            ],
323

            "y": [
324

              611.1204,
325

              613.677400000001,
326

              612.839200000001,
327

              610.480600000001,
328

              611.0998,
329

              611.460200000001,
330

              612.122200000001,
331

              612.902600000001,
332

              612.833200000001,
333

              610.8344
334

            ],
335

            "text": [
336

              "corridor_width: 465.3654<br />mean_elevation_of_turtles: 611.1204<br />ordered(q): 0.5<br />ordered(q): 0.5",
337

              "corridor_width: 475.7747<br />mean_elevation_of_turtles: 613.6774<br />ordered(q): 0.5<br />ordered(q): 0.5",
338

              "corridor_width: 483.6789<br />mean_elevation_of_turtles: 612.8392<br />ordered(q): 0.5<br />ordered(q): 0.5",
339

              "corridor_width: 484.7854<br />mean_elevation_of_turtles: 610.4806<br />ordered(q): 0.5<br />ordered(q): 0.5",
340

              "corridor_width: 485.8863<br />mean_elevation_of_turtles: 611.0998<br />ordered(q): 0.5<br />ordered(q): 0.5",
341

              "corridor_width: 491.8704<br />mean_elevation_of_turtles: 611.4602<br />ordered(q): 0.5<br />ordered(q): 0.5",
342

              "corridor_width: 500.0298<br />mean_elevation_of_turtles: 612.1222<br />ordered(q): 0.5<br />ordered(q): 0.5",
343

              "corridor_width: 501.1249<br />mean_elevation_of_turtles: 612.9026<br />ordered(q): 0.5<br />ordered(q): 0.5",
344

              "corridor_width: 506.3349<br />mean_elevation_of_turtles: 612.8332<br />ordered(q): 0.5<br />ordered(q): 0.5",
345

              "corridor_width: 509.1383<br />mean_elevation_of_turtles: 610.8344<br />ordered(q): 0.5<br />ordered(q): 0.5"
346

            ],
347

            "type": "scatter",
348

            "mode": "lines+markers",
349

            "line": {
350

              "width": 1.88976377952756,
351

              "color": "rgba(0,191,125,1)",
352

              "dash": "solid"
353

            },
354

            "hoveron": "points",
355

            "name": "0.5",
356

            "legendgroup": "0.5",
357

            "showlegend": true,
358

            "xaxis": "x",
359

            "yaxis": "y",
360

            "hoverinfo": "text",
361

            "marker": {
362

              "autocolorscale": false,
363

              "color": "rgba(0,191,125,1)",
364

              "opacity": 1,
365

              "size": 5.66929133858268,
366

              "symbol": "circle",
367

              "line": {
368

                "width": 1.88976377952756,
369

                "color": "rgba(0,191,125,1)"
370

              }
371

            },
372

            "frame": null
373

          },
374

          {
375

            "x": [
376

              426.123854426042,
377

              427.65191968242,
378

              432.228468311772,
379

              438.549083783543,
380

              445.695544305838,
381

              445.698016487599,
382

              453.957947505638,
383

              455.274193963226,
384

              457.294771334458,
385

              465.493532207242
386

            ],
387

            "y": [
388

              604.7944,
389

              599.869000000001,
390

              601.0948,
391

              601.106,
392

              600.2304,
393

              599.921,
394

              595.678000000001,
395

              600.695600000001,
396

              600.498600000001,
397

              601.866200000001
398

            ],
399

            "text": [
400

              "corridor_width: 426.1239<br />mean_elevation_of_turtles: 604.7944<br />ordered(q): 0.75<br />ordered(q): 0.75",
401

              "corridor_width: 427.6519<br />mean_elevation_of_turtles: 599.8690<br />ordered(q): 0.75<br />ordered(q): 0.75",
402

              "corridor_width: 432.2285<br />mean_elevation_of_turtles: 601.0948<br />ordered(q): 0.75<br />ordered(q): 0.75",
403

              "corridor_width: 438.5491<br />mean_elevation_of_turtles: 601.1060<br />ordered(q): 0.75<br />ordered(q): 0.75",
404

              "corridor_width: 445.6955<br />mean_elevation_of_turtles: 600.2304<br />ordered(q): 0.75<br />ordered(q): 0.75",
405

              "corridor_width: 445.6980<br />mean_elevation_of_turtles: 599.9210<br />ordered(q): 0.75<br />ordered(q): 0.75",
406

              "corridor_width: 453.9579<br />mean_elevation_of_turtles: 595.6780<br />ordered(q): 0.75<br />ordered(q): 0.75",
407

              "corridor_width: 455.2742<br />mean_elevation_of_turtles: 600.6956<br />ordered(q): 0.75<br />ordered(q): 0.75",
408

              "corridor_width: 457.2948<br />mean_elevation_of_turtles: 600.4986<br />ordered(q): 0.75<br />ordered(q): 0.75",
409

              "corridor_width: 465.4935<br />mean_elevation_of_turtles: 601.8662<br />ordered(q): 0.75<br />ordered(q): 0.75"
410

            ],
411

            "type": "scatter",
412

            "mode": "lines+markers",
413

            "line": {
414

              "width": 1.88976377952756,
415

              "color": "rgba(0,176,246,1)",
416

              "dash": "solid"
417

            },
418

            "hoveron": "points",
419

            "name": "0.75",
420

            "legendgroup": "0.75",
421

            "showlegend": true,
422

            "xaxis": "x",
423

            "yaxis": "y",
424

            "hoverinfo": "text",
425

            "marker": {
426

              "autocolorscale": false,
427

              "color": "rgba(0,176,246,1)",
428

              "opacity": 1,
429

              "size": 5.66929133858268,
430

              "symbol": "circle",
431

              "line": {
432

                "width": 1.88976377952756,
433

                "color": "rgba(0,176,246,1)"
434

              }
435

            },
436

            "frame": null
437

          },
438

          {
439

            "x": [
440

              319.114814069623,
441

              326.447071577015,
442

              330.272895391643,
443

              336.004878409297,
444

              338.63609496079,
445

              346.44301252137,
446

              349.623500066988,
447

              349.76632958661,
448

              357.755405001306,
449

              359.789368340842
450

            ],
451

            "y": [
452

              579.4848,
453

              575.960199999999,
454

              577.9724,
455

              577.0492,
456

              573.9846,
457

              577.524,
458

              577.1588,
459

              571.875,
460

              578.1512,
461

              577.4514
462

            ],
463

            "text": [
464

              "corridor_width: 319.1148<br />mean_elevation_of_turtles: 579.4848<br />ordered(q): 1<br />ordered(q): 1",
465

              "corridor_width: 326.4471<br />mean_elevation_of_turtles: 575.9602<br />ordered(q): 1<br />ordered(q): 1",
466

              "corridor_width: 330.2729<br />mean_elevation_of_turtles: 577.9724<br />ordered(q): 1<br />ordered(q): 1",
467

              "corridor_width: 336.0049<br />mean_elevation_of_turtles: 577.0492<br />ordered(q): 1<br />ordered(q): 1",
468

              "corridor_width: 338.6361<br />mean_elevation_of_turtles: 573.9846<br />ordered(q): 1<br />ordered(q): 1",
469

              "corridor_width: 346.4430<br />mean_elevation_of_turtles: 577.5240<br />ordered(q): 1<br />ordered(q): 1",
470

              "corridor_width: 349.6235<br />mean_elevation_of_turtles: 577.1588<br />ordered(q): 1<br />ordered(q): 1",
471

              "corridor_width: 349.7663<br />mean_elevation_of_turtles: 571.8750<br />ordered(q): 1<br />ordered(q): 1",
472

              "corridor_width: 357.7554<br />mean_elevation_of_turtles: 578.1512<br />ordered(q): 1<br />ordered(q): 1",
473

              "corridor_width: 359.7894<br />mean_elevation_of_turtles: 577.4514<br />ordered(q): 1<br />ordered(q): 1"
474

            ],
475

            "type": "scatter",
476

            "mode": "lines+markers",
477

            "line": {
478

              "width": 1.88976377952756,
479

              "color": "rgba(231,107,243,1)",
480

              "dash": "solid"
481

            },
482

            "hoveron": "points",
483

            "name": "1",
484

            "legendgroup": "1",
485

            "showlegend": true,
486

            "xaxis": "x",
487

            "yaxis": "y",
488

            "hoverinfo": "text",
489

            "marker": {
490

              "autocolorscale": false,
491

              "color": "rgba(231,107,243,1)",
492

              "opacity": 1,
493

              "size": 5.66929133858268,
494

              "symbol": "circle",
495

              "line": {
496

                "width": 1.88976377952756,
497

                "color": "rgba(231,107,243,1)"
498

              }
499

            },
500

            "frame": null
501

          }
502

        ],
503

        "layout": {
504

          "margin": {
505

            "t": 36.9547530095475,
506

            "r": 13.2835201328352,
507

            "b": 75.4171855541719,
508

            "l": 78.3727687837277
509

          },
510

          "plot_bgcolor": "rgba(255,255,255,1)",
511

          "paper_bgcolor": "rgba(255,255,255,1)",
512

          "font": {
513

            "color": "rgba(0,0,0,1)",
514

            "family": "",
515

            "size": 26.5670402656704
516

          },
517

          "xaxis": {
518

            "domain": [
519

              0,
520

              1
521

            ],
522

            "automargin": true,
523

            "type": "linear",
524

            "autorange": false,
525

            "range": [
526

              295.97484130297,
527

              805.054242169332
528

            ],
529

            "tickmode": "array",
530

            "ticktext": [
531

              "300",
532

              "400",
533

              "500",
534

              "600",
535

              "700",
536

              "800"
537

            ],
538

            "tickvals": [
539

              300,
540

              400,
541

              500,
542

              600,
543

              700,
544

              800
545

            ],
546

            "categoryorder": "array",
547

            "categoryarray": [
548

              "300",
549

              "400",
550

              "500",
551

              "600",
552

              "700",
553

              "800"
554

            ],
555

            "nticks": null,
556

            "ticks": "outside",
557

            "tickcolor": "rgba(51,51,51,1)",
558

            "ticklen": 6.6417600664176,
559

            "tickwidth": 1.20759273934865,
560

            "showticklabels": true,
561

            "tickfont": {
562

              "color": "rgba(77,77,77,1)",
563

              "family": "",
564

              "size": 21.2536322125363
565

            },
566

            "tickangle": 0,
567

            "showline": false,
568

            "linecolor": null,
569

            "linewidth": 0,
570

            "showgrid": true,
571

            "gridcolor": "rgba(235,235,235,1)",
572

            "gridwidth": 1.20759273934865,
573

            "zeroline": false,
574

            "anchor": "y",
575

            "title": {
576

              "text": "corridor width",
577

              "font": {
578

                "color": "rgba(0,0,0,1)",
579

                "family": "",
580

                "size": 26.5670402656704
581

              }
582

            },
583

            "hoverformat": ".2f"
584

          },
585

          "yaxis": {
586

            "domain": [
587

              0,
588

              1
589

            ],
590

            "automargin": true,
591

            "type": "linear",
592

            "autorange": false,
593

            "range": [
594

              537.8459,
595

              622.600899999999
596

            ],
597

            "tickmode": "array",
598

            "ticktext": [
599

              "540",
600

              "560",
601

              "580",
602

              "600",
603

              "620"
604

            ],
605

            "tickvals": [
606

              540,
607

              560,
608

              580,
609

              600,
610

              620
611

            ],
612

            "categoryorder": "array",
613

            "categoryarray": [
614

              "540",
615

              "560",
616

              "580",
617

              "600",
618

              "620"
619

            ],
620

            "nticks": null,
621

            "ticks": "outside",
622

            "tickcolor": "rgba(51,51,51,1)",
623

            "ticklen": 6.6417600664176,
624

            "tickwidth": 1.20759273934865,
625

            "showticklabels": true,
626

            "tickfont": {
627

              "color": "rgba(77,77,77,1)",
628

              "family": "",
629

              "size": 21.2536322125363
630

            },
631

            "tickangle": 0,
632

            "showline": false,
633

            "linecolor": null,
634

            "linewidth": 0,
635

            "showgrid": true,
636

            "gridcolor": "rgba(235,235,235,1)",
637

            "gridwidth": 1.20759273934865,
638

            "zeroline": false,
639

            "anchor": "x",
640

            "title": {
641

              "text": "elevation",
642

              "font": {
643

                "color": "rgba(0,0,0,1)",
644

                "family": "",
645

                "size": 26.5670402656704
646

              }
647

            },
648

            "hoverformat": ".2f"
649

          },
650

          "shapes": [
651

            {
652

              "type": "rect",
653

              "fillcolor": "transparent",
654

              "line": {
655

                "color": "rgba(51,51,51,1)",
656

                "width": 1.20759273934865,
657

                "linetype": "solid"
658

              },
659

              "yref": "paper",
660

              "xref": "paper",
661

              "x0": 0,
662

              "x1": 1,
663

              "y0": 0,
664

              "y1": 1
665

            }
666

          ],
667

          "showlegend": true,
668

          "legend": {
669

            "bgcolor": "rgba(255,255,255,1)",
670

            "bordercolor": "transparent",
671

            "borderwidth": 3.43593414459556,
672

            "font": {
673

              "color": "rgba(0,0,0,1)",
674

              "family": "",
675

              "size": 21.2536322125363
676

            },
677

            "title": {
678

              "text": "q",
679

              "font": {
680

                "color": "rgba(0,0,0,1)",
681

                "family": "",
682

                "size": 26.5670402656704
683

              }
684

            }
685

          },
686

          "hovermode": "closest",
687

          "width": 631,
688

          "height": 400,
689

          "barmode": "relative"
690

        },
691

        "config": {
692

          "doubleClick": "reset",
693

          "modeBarButtonsToAdd": [
694

            "hoverclosest",
695

            "hovercompare"
696

          ],
697

          "showSendToCloud": false
698

        },
699

        "source": "A",
700

        "highlight": {
701

          "on": "plotly_click",
702

          "persistent": false,
703

          "dynamic": false,
704

          "selectize": false,
705

          "opacityDim": 0.2,
706

          "selected": {
707

            "opacity": 1
708

          },
709

          "debounce": 0
710

        },
711

        "shinyEvents": [
712

          "plotly_hover",
713

          "plotly_click",
714

          "plotly_selected",
715

          "plotly_relayout",
716

          "plotly_brushed",
717

          "plotly_brushing",
718

          "plotly_clickannotation",
719

          "plotly_doubleclick",
720

          "plotly_deselect",
721

          "plotly_afterplot",
722

          "plotly_sunburstclick"
723

        ],
724

        "base_url": "https://plot.ly"
725

      },
726

      "evals": [
727

728

      ],
729

      "jsHooks": [
730

731

      ],
732

      "deps": [
733

        {
734

          "name": "setprototypeof",
735

          "version": "0.1",
736

          "src": {
737

            "href": "setprototypeof-0.1"
738

          },
739

          "meta": null,
740

          "script": "setprototypeof.js",
741

          "stylesheet": null,
742

          "head": null,
743

          "attachment": null,
744

          "all_files": false
745

        },
746

        {
747

          "name": "typedarray",
748

          "version": "0.1",
749

          "src": {
750

            "href": "typedarray-0.1"
751

          },
752

          "meta": null,
753

          "script": "typedarray.min.js",
754

          "stylesheet": null,
755

          "head": null,
756

          "attachment": null,
757

          "all_files": false
758

        },
759

        {
760

          "name": "jquery",
761

          "version": "3.5.1",
762

          "src": {
763

            "href": "jquery-3.5.1"
764

          },
765

          "meta": null,
766

          "script": "jquery.min.js",
767

          "stylesheet": null,
768

          "head": null,
769

          "attachment": null,
770

          "all_files": true
771

        },
772

        {
773

          "name": "crosstalk",
774

          "version": "1.2.0",
775

          "src": {
776

            "href": "crosstalk-1.2.0"
777

          },
778

          "meta": null,
779

          "script": "js/crosstalk.min.js",
780

          "stylesheet": "css/crosstalk.min.css",
781

          "head": null,
782

          "attachment": null,
783

          "all_files": true
784

        },
785

        {
786

          "name": "plotly-htmlwidgets-css",
787

          "version": "2.5.1",
788

          "src": {
789

            "href": "plotly-htmlwidgets-css-2.5.1"
790

          },
791

          "meta": null,
792

          "script": null,
793

          "stylesheet": "plotly-htmlwidgets.css",
794

          "head": null,
795

          "attachment": null,
796

          "all_files": false
797

        },
798

        {
799

          "name": "plotly-main",
800

          "version": "2.5.1",
801

          "src": {
802

            "href": "plotly-main-2.5.1"
803

          },
804

          "meta": null,
805

          "script": "plotly-latest.min.js",
806

          "stylesheet": null,
807

          "head": null,
808

          "attachment": null,
809

          "all_files": false
810

        }
811

      ]
812

    },
813

    "table": {
814

      "x": {
815

        "filter": "none",
816

        "vertical": false,
817

        "container": "<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>corridor_width<\/th>\n      <th>q<\/th>\n      <th>mean_elevation_of_turtles<\/th>\n      <th>mean_elevation_of_turtles_sd<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>",
818

        "options": {
819

          "lengthChange": false,
820

          "bFilter": false,
821

          "columnDefs": [
822

            {
823

              "className": "dt-right",
824

              "targets": [
825

                1,
826

                2,
827

                3,
828

                4
829

              ]
830

            },
831

            {
832

              "orderable": false,
833

              "targets": 0
834

            }
835

          ],
836

          "order": [
837

838

          ],
839

          "autoWidth": false,
840

          "orderClasses": false,
841

          "ajax": {
842

            "type": "POST",
843

            "data": "function(d) {\nd.search.caseInsensitive = true;\nd.search.smart = true;\nd.escape = true;\nvar encodeAmp = function(x) { x.value = x.value.replace(/&/g, \"%26\"); }\nencodeAmp(d.search);\n$.each(d.columns, function(i, v) {encodeAmp(v.search);});\n}"
844

          },
845

          "serverSide": true,
846

          "processing": true
847

        },
848

        "selection": {
849

          "mode": "multiple",
850

          "selected": null,
851

          "target": "row",
852

          "selectable": null
853

        }
854

      },
855

      "evals": [
856

        "options.ajax.data"
857

      ],
858

      "jsHooks": [
859

860

      ],
861

      "deps": [
862

        {
863

          "name": "jquery",
864

          "version": "3.6.0",
865

          "src": {
866

            "href": "jquery-3.6.0"
867

          },
868

          "meta": null,
869

          "script": "jquery-3.6.0.min.js",
870

          "stylesheet": null,
871

          "head": null,
872

          "attachment": null,
873

          "all_files": true
874

        },
875

        {
876

          "name": "dt-core",
877

          "version": "1.11.3",
878

          "src": {
879

            "href": "dt-core-1.11.3"
880

          },
881

          "meta": null,
882

          "script": "js/jquery.dataTables.min.js",
883

          "stylesheet": [
884

            "css/jquery.dataTables.min.css",
885

            "css/jquery.dataTables.extra.css"
886

          ],
887

          "head": null,
888

          "attachment": null,
889

          "package": null,
890

          "all_files": false
891

        },
892

        {
893

          "name": "crosstalk",
894

          "version": "1.2.0",
895

          "src": {
896

            "href": "crosstalk-1.2.0"
897

          },
898

          "meta": null,
899

          "script": "js/crosstalk.min.js",
900

          "stylesheet": "css/crosstalk.min.css",
901

          "head": null,
902

          "attachment": null,
903

          "all_files": true
904

        }
905

      ]
906

    }
907

  },
908

  "export": {
909

910

  }
911

}
  app$set_inputs(ren_to = "Corridor width")
  app$click("rename")
  app$expect_values()
  app$set_inputs(ren_from = "mean_elevation_of_turtles")
  app$set_inputs(ren_to = "Elevation")
  app$click("rename")
  app$expect_values()
  app$set_inputs(x_var = "q")
  app$set_inputs(y_var = "corridor_width")
  app$set_inputs(lines = TRUE)
  app$expect_screenshot()
  app$set_inputs(error_bars = "error bars")
  app$set_inputs(lines = FALSE)
  app$expect_screenshot()
  app$set_inputs(lines = TRUE)
  app$set_inputs(error_bars = "bands")
  app$expect_screenshot()
  app$set_inputs(x_var = "corridor_width")
  app$set_inputs(y_var = "mean_elevation_of_turtles")
  app$set_inputs(group_var = "q")
  app$set_inputs(summary_tab = TRUE)
  app$expect_values()
  app$expect_screenshot()
})
