class Visit {
  String? sId;
  String? dateStart;
  String? dateEnd;
  ServerId? serverId;
  String? visitType;
  String? visitTypeSource;
  String? npi1;
  String? npi2;
  Resources? resources;
  List<NewDocs>? newDocs;
  List<Tasks>? tasksForUser;
  List<String>? instructionsForUser;
  String? longSummary;
  String? shortSummary;
  String? doctorSummary;
  List<Tasks>? validatedTasksForUser;
  List<String>? validatedInstructionsForUser;
  String? validatedLongSummary;
  String? validatedShortSummary;
  String? validatedDoctorSummary;

  Visit(
      {this.sId,
        this.dateStart,
        this.dateEnd,
        this.serverId,
        this.visitType,
        this.visitTypeSource,
        this.npi1,
        this.npi2,
        this.resources,
        this.newDocs,
        this.tasksForUser,
        this.instructionsForUser,
        this.longSummary,
        this.shortSummary,
        this.doctorSummary,
        this.validatedTasksForUser,
        this.validatedInstructionsForUser,
        this.validatedLongSummary,
        this.validatedShortSummary,
        this.validatedDoctorSummary});

  Visit.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    serverId = json['serverId'] != null
        ? new ServerId.fromJson(json['serverId'])
        : null;
    visitType = json['visitType'];
    visitTypeSource = json['visitTypeSource'];
    npi1 = json['npi1'];
    npi2 = json['npi2'];
    resources = json['resources'] != null
        ? new Resources.fromJson(json['resources'])
        : null;
    if (json['newDocs'] != null) {
      newDocs = <NewDocs>[];
      json['newDocs'].forEach((v) {
        newDocs!.add(NewDocs.fromJson(v));
      });
    }
    if (json['tasksForUser'] != null) {
      tasksForUser = <Tasks>[];
      json['tasksForUser'].forEach((v) {
        tasksForUser!.add(new Tasks.fromJson(v));
      });
    }
    instructionsForUser = json['instructionsForUser']?.cast<String>();
    longSummary = json['longSummary'];
    shortSummary = json['shortSummary'];
    doctorSummary = json['doctorSummary'];
    if (json['validatedTasksForUser'] != null) {
      validatedTasksForUser = <Tasks>[];
      json['validatedTasksForUser'].forEach((v) {
        validatedTasksForUser!.add(new Tasks.fromJson(v));
      });
    }
    validatedInstructionsForUser =
        json['validatedInstructionsForUser']?.cast<String>();
    validatedLongSummary = json['validatedLongSummary'];
    validatedShortSummary = json['validatedShortSummary'];
    validatedDoctorSummary = json['validatedDoctorSummary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['dateStart'] = this.dateStart;
    data['dateEnd'] = this.dateEnd;
    if (this.serverId != null) {
      data['serverId'] = this.serverId!.toJson();
    }
    data['visitType'] = this.visitType;
    data['visitTypeSource'] = this.visitTypeSource;
    data['npi1'] = this.npi1;
    data['npi2'] = this.npi2;
    if (this.resources != null) {
      data['resources'] = this.resources!.toJson();
    }
    if (this.newDocs != null) {
      data['newDocs'] = this.newDocs!.map((v) => v.toJson()).toList();
    }
    if (this.tasksForUser != null) {
      data['tasksForUser'] = this.tasksForUser!.map((v) => v.toJson()).toList();
    }
    data['instructionsForUser'] = this.instructionsForUser;
    data['longSummary'] = this.longSummary;
    data['shortSummary'] = this.shortSummary;
    data['doctorSummary'] = this.doctorSummary;
    if (this.validatedTasksForUser != null) {
      data['validatedTasksForUser'] =
          this.validatedTasksForUser!.map((v) => v.toJson()).toList();
    }
    data['validatedInstructionsForUser'] = this.validatedInstructionsForUser;
    data['validatedLongSummary'] = this.validatedLongSummary;
    data['validatedShortSummary'] = this.validatedShortSummary;
    data['validatedDoctorSummary'] = this.validatedDoctorSummary;
    return data;
  }
}

class ServerId {
  String? emr;
  String? payer;

  ServerId({this.emr, this.payer});

  ServerId.fromJson(Map<String, dynamic> json) {
    emr = json['emr'];
    payer = json['payer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emr'] = this.emr;
    data['payer'] = this.payer;
    return data;
  }
}

class Resources {
  List<String>? encounter;
  List<String>? condition;
  List<String>? diagnosticReport;
  List<String>? medicationRequest;
  List<String>? documentReference;

  Resources(
      {this.encounter,
        this.condition,
        this.diagnosticReport,
        this.medicationRequest,
        this.documentReference});

  Resources.fromJson(Map<String, dynamic> json) {
    encounter = json['Encounter']?.cast<String>();
    condition = json['Condition']?.cast<String>();
    diagnosticReport = json['DiagnosticReport']?.cast<String>();
    medicationRequest = json['MedicationRequest']?.cast<String>();
    documentReference = json['DocumentReference']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Encounter'] = this.encounter;
    data['Condition'] = this.condition;
    data['DiagnosticReport'] = this.diagnosticReport;
    data['MedicationRequest'] = this.medicationRequest;
    data['DocumentReference'] = this.documentReference;
    return data;
  }
}

class NewDocs {
  String? resourceType;
  String? practioner;
  String? location;
  String? startDate;
  String? endDate;
  String? type;
  String? lastUpdated;
  String? verificationStatus;
  String? display;
  String? category;
  dynamic? result;
  String? data;
  String? dosageStart;
  String? dosageEnd;
  int? dosageFrequency;
  int? periodUnit;
  bool? asNeededBoolean;
  String? patientInstruction;

  NewDocs(
      {this.resourceType,
        this.practioner,
        this.location,
        this.startDate,
        this.endDate,
        this.type,
        this.lastUpdated,
        this.verificationStatus,
        this.display,
        this.category,
        this.result,
        this.data,
        this.dosageStart,
        this.dosageEnd,
        this.dosageFrequency,
        this.periodUnit,
        this.asNeededBoolean,
        this.patientInstruction});

  NewDocs.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    practioner = json['practioner'];
    location = json['location'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    type = json['type'];
    lastUpdated = json['lastUpdated'];
    verificationStatus = json['verificationStatus'];
    display = json['display'];
    category = json['category'];
    result = json['result'];
    data = json['data'];
    dosageStart = json['dosageStart'];
    dosageEnd = json['dosageEnd'];
    dosageFrequency = json['dosageFrequency'];
    periodUnit = json['periodUnit'];
    asNeededBoolean = json['asNeededBoolean'];
    patientInstruction = json['patientInstruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceType'] = this.resourceType;
    data['practioner'] = this.practioner;
    data['location'] = this.location;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['type'] = this.type;
    data['lastUpdated'] = this.lastUpdated;
    data['verificationStatus'] = this.verificationStatus;
    data['display'] = this.display;
    data['category'] = this.category;
    data['result'] = this.result;
    data['data'] = this.data;
    data['dosageStart'] = this.dosageStart;
    data['dosageEnd'] = this.dosageEnd;
    data['dosageFrequency'] = this.dosageFrequency;
    data['periodUnit'] = this.periodUnit;
    data['asNeededBoolean'] = this.asNeededBoolean;
    data['patientInstruction'] = this.patientInstruction;
    return data;
  }
}

class Tasks {
  String? id;
  String? task;
  String? status;
  String? note;

  Tasks({this.id, this.task, this.status, this.note});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'];
    status = json['status'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task'] = this.task;
    data['status'] = this.status;
    data['note'] = this.note;
    return data;
  }
}