package com.dollyanddot.kingmaker.domain.routine.controller;

import com.dollyanddot.kingmaker.domain.routine.dto.request.PostRoutineReqDto;
import com.dollyanddot.kingmaker.domain.routine.dto.response.PostRoutineResDto;
import com.dollyanddot.kingmaker.domain.routine.service.RoutineService;
import com.dollyanddot.kingmaker.global.common.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/routine")
@RequiredArgsConstructor
public class RoutineController {

  private final RoutineService routineService;

  @PostMapping()
  public EnvelopeResponse<PostRoutineResDto> registerRoutine(@RequestBody PostRoutineReqDto postRoutineReqDto){
    return EnvelopeResponse.<PostRoutineResDto>builder()
        .data(routineService.registerRoutine(postRoutineReqDto))
        .build();
  }
}
