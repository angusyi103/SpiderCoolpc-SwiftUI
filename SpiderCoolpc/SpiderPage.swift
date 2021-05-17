//
//  SpiderPage.swift
//  SpiderCoolpc
//
//  Created by Angus Yi on 2021/4/25.
//

import SwiftUI

struct SpiderPage: View {
    
    @ObservedObject var gpuDataHandler = GPUDataHandler()
    
    var body: some View {
        Button("Refresh", action: {
            gpuDataHandler.getCoolpcGPUDatas()
        }).onAppear {
            gpuDataHandler.getCoolpcGPUDatas()
        }
        
        List {
            let headerGpuInfo = GPUInfo(model: "型號", brand: "廠牌", MHz: "MHz", length: "長度", warranty: "保固", price: "價錢")
            ScrollView(.horizontal, showsIndicators: true) {
                Section(header: GPUListCell(gpu: headerGpuInfo)) {
                    ForEach(gpuDataHandler.gpuInfoAry) { gpu in
                        GPUListCell(gpu: gpu)
                            .frame(height: 20, alignment: .center)
                    }
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 20)
    }
}

#if DEBUG
struct SpiderPage_Previews: PreviewProvider {
    static var previews: some View {
        SpiderPage()
    }
}
#endif

struct GPUListCell: View {
    let gpu: GPUInfo
    let gpuInfoStringMaxLength = GpuInfoStringMaxLength.shared
    var body: some View {
        HStack {
            Group {
                Text(gpu.brand ?? "").frame(width: CGFloat(gpuInfoStringMaxLength.brand ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.model ?? "").frame(width: CGFloat(gpuInfoStringMaxLength.model ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.MHz ?? "").frame(width: CGFloat(gpuInfoStringMaxLength.MHz ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.length ?? "").frame(width: CGFloat(gpuInfoStringMaxLength.length ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.warranty ?? "").frame(width: CGFloat(gpuInfoStringMaxLength.warranty ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.price ?? "").frame(width: CGFloat(gpuInfoStringMaxLength.price ?? 0) + 10, height: nil, alignment: .center)
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Spacer()
        }
    }
}
