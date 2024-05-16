package egovframework.admin.openinf.service;

import java.util.LinkedList;
import java.util.List;

import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.base.model.Result;

public interface OpenDsInputService {

    public List<Record> selectOption(Params params);

    List<Record> openDsInputList(Params params);

    Record openDsInputDtl(Params params);

    List<Record> openDsInputCol(Params params);

    List<Record> openDsInputData(Params params);

    LinkedList<LinkedList<String>> down2OpenDsInputForm(Params params);

    Result saveOpenInputData(Params params);

    Result saveOpenInputExcelData(Params params);

    List<Record> openDsInputVerifyData(Params params);

    Result updateOpenLdlistCd(Params params);
}
